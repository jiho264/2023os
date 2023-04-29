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

OBJECT user = {20, 100, BOX_AZ, BOX_EL, 10, 10};
OBJECT comp = {XLIM - 2 * BOX_AZ, 100, BOX_AZ, BOX_EL, 10, 10};
OBJECT ball = {XLIM / 2, YLIM / 2, BALL_2R, BALL_2R, 5, 5};

// 도형 그리기
void Draw_Object(HWND hWnd, HDC hdc, HBRUSH hBrush, OBJECT prt, BOOL _is_rect)
{

    HBRUSH oBrush;                              // DC에 기존 선택 브러쉬 핸들 기억할 변수
    oBrush = (HBRUSH)SelectObject(hdc, hBrush); // 입력 인자로 전달받은 브러쉬를 DC에 선택

    if (_is_rect == 1)
        Rectangle(hdc, prt.x, prt.y, prt.x + prt.az, prt.y + prt.el); // 사각형 그리기
    else
        Ellipse(hdc, prt.x, prt.y, prt.x + prt.az, prt.y + prt.el); // 타원 그리기

    SelectObject(hdc, oBrush); // 기존 선택 브러쉬를 DC에 선택
}
// 그리기 작업
void Draw_ALL(HWND hWnd)
{
    // 펜과 브러쉬 스타일 문자열 조합
    // wsprintf(buf, TEXT("%s, %s"), pstrs[pi], bstrs[bi]);
    // 츨력할 좌표 설정
    // 펜과 브러쉬 스타일 문자열 출력
    // TextOut(hdc, 100, 100, "x", 1);
    // 특정 펜과 브러쉬로 도형 출력

    PAINTSTRUCT ps;
    BeginPaint(hWnd, &ps);

    Draw_Object(hWnd, ps.hdc, CreateSolidBrush(RGB(255, 0, 0)), user, 1);
    Draw_Object(hWnd, ps.hdc, CreateSolidBrush(RGB(0, 255, 0)), comp, 1);
    Draw_Object(hWnd, ps.hdc, CreateSolidBrush(RGB(0, 0, 0)), ball, 0);
    InvalidateRect(hWnd, 0, TRUE);
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
            user.y -= 10;
            break;
        }
        case VK_DOWN:
        {
            user.y += 10;
            break;
        }
        default:
            return;
        }
    }
    case WM_PAINT:
    {
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
                             TEXT("그리기 예제"), // 캡션 명
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
    }
    return 0;
}
