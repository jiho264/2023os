#include <Windows.h>
#define MY_DRAW_WND (TEXT("ex_drawing"))
#define XLIM 640
#define YLIM 480
#define BAR_AZ 20
#define BAR_EL 100
#define BOX_AZ 20
#define BOX_EL 100
#define BALL_2R 15
typedef struct OBJECT
{
    int x, y;
    int az, el;
    int dx, dy;
} OBJECT;

OBJECT user = {20, 100, BOX_AZ, BOX_EL, 0, 15};
OBJECT comp = {XLIM - 2 * BOX_AZ, 100, BOX_AZ, BOX_EL, 0, -1};
OBJECT ball = {XLIM / 2 - 100, YLIM / 2, BALL_2R, BALL_2R, -1, -1};

// 도형 그리기
void Draw_Object(HWND hWnd, HDC hdc, HBRUSH hBrush, OBJECT prt, BOOL _is_rect)
{

    HBRUSH oBrush;                              // DC에 기존 선택 브러쉬 핸들 기억할 변수
    oBrush = (HBRUSH)SelectObject(hdc, hBrush); // 입력 인자로 전달받은 브러쉬를 DC에 선택

    if (_is_rect == 1)
        Rectangle(hdc, prt.x, prt.y, prt.x + BOX_AZ, prt.y + BOX_EL); // 사각형 그리기
    else
        Ellipse(hdc, prt.x, prt.y, prt.x + BALL_2R, prt.y + BALL_2R); // 타원 그리기

    RECT _tmp = {prt.x, prt.y, prt.x + prt.az, prt.y + prt.el};
    InvalidateRect(hWnd, &_tmp, TRUE);

    SelectObject(hdc, oBrush); // 기존 선택 브러쉬를 DC에 선택
}
// 그리기 작업
void Draw_ALL(HWND hWnd)
{
    // 츨력할 좌표 설정
    // TextOut(hdc, 100, 100, "x", 1);

    PAINTSTRUCT ps;
    BeginPaint(hWnd, &ps);

    Draw_Object(hWnd, ps.hdc, CreateSolidBrush(RGB(255, 0, 0)), user, 1);
    Draw_Object(hWnd, ps.hdc, CreateSolidBrush(RGB(0, 255, 0)), comp, 1);
    // 공 날라갈 때 조금 덜 그려짐
    Draw_Object(hWnd, ps.hdc, CreateSolidBrush(RGB(0, 0, 0)), ball, 0);
    EndPaint(hWnd, &ps);
}

/* key*/
LRESULT CALLBACK MyWndProc(HWND hWnd, UINT iMessage, WPARAM wParam, LPARAM lParam)
{
    int _upanddown = -999;
    switch (iMessage)
    {
    case WM_KEYDOWN:
    {
        switch (wParam)
        {
        case VK_UP:
        {
            // bar가 경계 닿는 순간
            if (user.y <= 0)
            {
            }
            else
                user.y -= user.dy;
            break;
        }
        case VK_DOWN:
        {
            // bar가 경계 닿는 순간
            if (user.y + 1.4 * BOX_EL >= YLIM)
            {
            }
            else
                user.y += user.dy;
            break;
        }
        default:
            return 0;
        }
    }
    case WM_PAINT:
    {
        // comp의 기본 움직임
        // bar가 경계 닿는 순간
        if (comp.y <= 0 || comp.y + 1.4 * BOX_EL >= YLIM)
        {
            comp.dy = -comp.dy;
        }
        comp.y += comp.dy;

        // 만약 공이 user에 닿음
        if (ball.x <= user.x + BOX_AZ)
        {
            if (user.y < ball.y && ball.y + BALL_2R < user.y + BOX_EL)
            {
                ball.dx = -ball.dx;
            }
        }
        // 만약 공이 comp에 닿음
        if (comp.x <= ball.x + BALL_2R)
        {
            if (comp.y < ball.y && ball.y + BALL_2R < comp.y + BOX_EL)
            {
                ball.dx = -ball.dx;
            }
        }
        // ball이 위나 아래에 부딪히면 반대로
        if (ball.y == 0 || ball.y + 3.5 * BALL_2R >= YLIM)
        {
            ball.dy = -ball.dy;
        }
        // 만약 comp가 ball을 놓쳐서 오른쪽 바깥으로 나감
        if (XLIM <= ball.x + BALL_2R)
        {
            // level up!
            comp.dy *= 2;
            // iniy ball
            ball.x = 500;
            ball.y = 250;
            ball.dx *= -ball.dx;
            ball.dy *= -ball.dy;
        }

        ball.x += ball.dx;
        ball.y += ball.dy;

        Draw_ALL(hWnd);
        return 0;
    }
    case WM_DESTROY:
        PostQuitMessage(0);
        return 0;
    }
    return DefWindowProc(hWnd, iMessage, wParam, lParam);
}

INT APIENTRY WinMain(HINSTANCE hIns, HINSTANCE hPrev, LPSTR cmd, INT nShow)
{
    WNDCLASS wndclass = {0};
    wndclass.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH); // 흰색 브러쉬 핸들
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
                             hIns,                // 인스턴스 핸들
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
