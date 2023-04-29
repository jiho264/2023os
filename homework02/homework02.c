#include <Windows.h>
LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, UINT wparam, LPARAM lparam)
{
    switch (msg)
    {
    case WM_CREATE: // 윈도우 생성되면 발생
        //     MessageBoxA(hwnd, "wm_create", "msg", MB_OK);
        break;
    case WM_PAINT:
    {
        HDC hdc;
        PAINTSTRUCT ps;
        hdc = BeginPaint(hwnd, &ps);

        Ellipse(hdc, 10, 10, 20, 20); // 원 그리기
        Rectangle(hdc, 10, 100, 20, 200);
        Rectangle(hdc, 300, 100, 310, 200);
        EndPaint(hwnd, &ps);
        break;
    }
    case WM_LBUTTONDOWN: // 왼쪽 마우스 누르면 발생
        MessageBoxA(hwnd, "wm_lbuttondown", "msg", MB_OK);
        break;
    case WM_CHAR: // 키 눌리면 발생
        // MessageBoxA(hwnd, "wm_char", "msg", MB_OK);
        break;
    }
    return DefWindowProcA(hwnd, msg, wparam, lparam);
}
int WINAPI WinMain(HINSTANCE hinstance, HINSTANCE, char *, int)
{
    WNDCLASSEXA win = {0};
    win.cbSize = sizeof(win);
    win.style = CS_HREDRAW | CS_VREDRAW;
    win.hInstance = hinstance;
    win.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);
    win.lpszClassName = "my window";
    win.lpfnWndProc = WndProc; // 나중에 배움
    RegisterClassExA(&win);
    HWND hwnd;
    hwnd = CreateWindowA(
        "my window",
        "hello world",
        WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX,
        CW_USEDEFAULT,
        CW_USEDEFAULT,
        CW_USEDEFAULT,
        CW_USEDEFAULT,
        0, 0, hinstance, 0);
    ShowWindow(hwnd, 1);
    MSG msg;
    while (GetMessageA(&msg, 0, 0, 0))
    {
        TranslateMessage(&msg);
        DispatchMessageA(&msg);
    }
    return 0;
}