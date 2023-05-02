#include <Windows.h>
#define MY_DRAW_WND (TEXT("ex_drawing"))
#define XLIM 640
#define YLIM 480
#define BAR_AZ 10
#define BAR_EL 100
#define BALL_2R 10
typedef struct OBJECT
{
    int x, y;
    int az, el;
    int dx, dy;
} OBJECT;

OBJECT user = {0, 100, BAR_AZ, BAR_EL, 0, 40};
OBJECT comp = {XLIM - 2.6 * BAR_AZ, 100, BAR_AZ, BAR_EL, 0, -1};
OBJECT ball = {XLIM / 2 - 100, YLIM / 2, BALL_2R, BALL_2R, -1, -1};

// 도형 그리기
void Draw_Object(HWND hWnd, HDC hdc, OBJECT prt, BOOL _is_rect)
{
    if (_is_rect == 1)
        Rectangle(hdc, prt.x, prt.y, prt.x + BAR_AZ, prt.y + BAR_EL); // 사각형 그리기
    else
        Ellipse(hdc, prt.x, prt.y, prt.x + BALL_2R, prt.y + BALL_2R); // 타원 그리기
    InvalidateRect(hWnd, 0, TRUE);
}

// 그리기 작업
void Draw_ALL(HWND hWnd)
{
    // 츨력할 좌표 설정
    // TextOut(hdc, 100, 100, "x", 1);
    PAINTSTRUCT ps;
    BeginPaint(hWnd, &ps);
    Draw_Object(hWnd, ps.hdc, user, 1);
    Draw_Object(hWnd, ps.hdc, comp, 1);
    Draw_Object(hWnd, ps.hdc, ball, 0);
    EndPaint(hWnd, &ps);
}

/* callback function */
LRESULT CALLBACK MyWndProc(HWND hWnd, UINT iMessage, WPARAM wParam, LPARAM lParam)
{
    switch (iMessage)
    {
    case WM_KEYDOWN:
    {
        switch (wParam)
        {
            // USER BAR MOVE
        case VK_UP:
        {
            // bar가 경계 닿지 않을 때에만 이동
            if (!(user.y <= 0))
                user.y -= user.dy;
            if (user.y < 0)
                while (user.y < 0)
                    user.y++;
            break;
        }
        case VK_DOWN:
        {
            // bar가 경계 닿지 않을 때에만 이동
            if (!(user.y + 1.4 * BAR_EL >= YLIM))
                user.y += user.dy;
            if (user.y + 1.4 * BAR_EL >= YLIM)
                while (user.y + 1.4 * BAR_EL >= YLIM)
                    user.y--;
            break;
        }
        default:
            return 0;
        }
    }
    case WM_PAINT:
    {
        // BALL MOVE
        int bb = ball.y;
        ball.x += ball.dx;
        ball.y += ball.dy;

        // COMP BAR MOVE
        // ball의 이동방향과 comp bar의 이동 방향 맞추기.
        if (bb < ball.y)
            comp.dy = abs(comp.dy);
        else
            comp.dy = -abs(comp.dy);
        // comp bar가 한번 더 움직일 때 상단에 닿을 것 같으면, 이동 방향 반대로
        if (comp.y + comp.dy < 0)
            comp.dy = abs(comp.dy);
        // comp bar가 한번 더 움직일 때 하단에 닿을 것 같으면, 이동 방향 반대로
        else if (comp.y + 1.4 * BAR_EL + comp.dy > YLIM)
            comp.dy = -abs(comp.dy);
        // 이동 가능한 범위면, 이동시키기
        else
            comp.y += comp.dy;

        // USER BAR BOUNCE
        // 공이 user 왼쪽으로 넘어갈 것 같을 떄,
        if (ball.x <= user.x + BAR_AZ)
        {
            // bar의 내부에 공이 존재한다면, 튕기기
            if (user.y < ball.y && ball.y + BALL_2R < user.y + BAR_EL)
            {
                ball.dx = -ball.dx;
                // 랠리 성공했으니, level up!
                // 공 속도 두배~
                if (ball.dx >= 0)
                    ball.dx += 1;
                else
                    ball.dx -= 1;
                if (ball.dy >= 0)
                    ball.dx += 1;
                else
                    ball.dy -= 1;
                // 공이 빠르게 움직였다면 bar를 넘어갈 수 있으니, 공간으로 다시 밀어내기
                while (ball.x < user.x + BAR_AZ)
                    ball.x++;
            }
        }
        // COMP BAR BOUNCE
        // 만약 공이 comp에 닿음 > 그냥 튕기기만
        if (comp.x <= ball.x + BALL_2R)
        {
            if (comp.y < ball.y && ball.y + BALL_2R < comp.y + BAR_EL)
            {
                ball.dx = -ball.dx;
                // 공이 빠르게 움직였다면 bar를 넘어갈 수 있으니, 공간으로 다시 밀어내기
                while (ball.x > comp.x)
                    ball.x--;
            }
        }
        // ball이 위나 아래에 부딪히면 반대로
        if (ball.y < 0 || ball.y + 5 * BALL_2R >= YLIM)
            ball.dy = -ball.dy;
        // 만약 user가 놓침 > exit
        if (ball.x <= 0)
        {
            PostQuitMessage(0);
            return;
            //  iniy ball
            /*ball.x = 500;
            ball.y = 250;
            ball.dx = -1;
            ball.dy = -1;
            comp.y = YLIM / 2;
            comp.dy = 1;*/
        }
        // 만약 comp가 ball을 놓쳐서 오른쪽 바깥으로 나감
        if (XLIM <= ball.x + BALL_2R)
        {
            // level up!
            if (comp.dy >= 0)
                comp.dy += 1;
            else
                comp.dy -= 1;

            if (ball.dx >= 0)
                ball.dx += 1;
            else
                ball.dx -= 1;
            // iniy ball
            ball.x = 500;
            ball.y = 250;
            ball.dx = -ball.dx;
            ball.dy = -ball.dy;
        }
        Draw_ALL(hWnd);
        return 0;
    }
    case WM_DESTROY:
        PostQuitMessage(0);
        return 0;
    }
    return DefWindowProc(hWnd, iMessage, wParam, lParam);
}
INT APIENTRY WinMain(
    _In_ HINSTANCE hIns,
    _In_opt_ HINSTANCE hPrev,
    _In_ LPSTR cmd,
    _In_ INT nShow)
{
    WNDCLASS wndclass = {0};
    wndclass.hbrBackground = (HBRUSH)GetStockObject(BLACK_BRUSH); // 흰색 브러쉬 핸들
    wndclass.hCursor = LoadCursor(0, IDC_ARROW);                  // 마우스 커서 핸들
    wndclass.hIcon = LoadIcon(0, IDI_APPLICATION);                // 아이콘 핸들
    wndclass.hInstance = GetModuleHandle(0);                      // 자신 모듈의 인스턴스 핸들
    wndclass.lpfnWndProc = MyWndProc;                             // 윈도우 콜백 프로시저
    wndclass.lpszClassName = MY_DRAW_WND;                         // 클래스 이름 - 클래스 구분자
    wndclass.style = CS_DBLCLKS;                                  // 클래스 종류

    RegisterClass(&wndclass); // 윈도우 클래스 등록

    // 윈도우 인스턴스 생성
    HWND hWnd = CreateWindow(MY_DRAW_WND,         // 클래스 이름
                             TEXT("homework02"),  // 캡션 명
                             WS_OVERLAPPEDWINDOW, // 윈도우 스타일
                             10, 10, XLIM, YLIM,  // 좌,상,폭,높이
                             0,                   // 부모 윈도우 핸들
                             0,                   // 메뉴 핸들
                             hIns,                // 인스턴스 핸들d
                             0);                  // 생성 시 전달 인자

    ShowWindow(hWnd, nShow); // 윈도우 인스턴스 시각화, SW_SHOW(시각화), SW_HIDE(비시각화)
    MSG Message;
    while (GetMessage(&Message, 0, 0, 0)) // 메시지 루프에서 메시지 꺼냄(WM_QUIT이면 FALSE 반환)
    {
        TranslateMessage(&Message); // WM_KEYDOWN이고 키가 문자 키일 때 WM_CHAR 발생
        DispatchMessage(&Message);  // 콜백 프로시저가 수행할 수 있게 디스패치 시킴
        Sleep(1);
    }
    return 0;
}

/*
참고 블로그
https://ehpub.co.kr/7-%ec%b2%ab-%eb%b2%88%ec%a7%b8-%ec%8b%a4%ec%8a%b5-%eb%8f%84%ed%98%95-%ec%9d%b4%eb%8f%99-%ec%8b%9c%ed%82%a4%ea%b8%b0/

*/