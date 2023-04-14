import numpy as np
import time
_ALL_USER_ = 100
_SUBWAY_ = 60
_result = set()
while (len(_result) < _SUBWAY_):
    # defalut range = [0, end -1]
    # ++ >> range = [1, end]
    _result.add(np.random.randint(_ALL_USER_)+1)
_result = list(_result)
print()
print(time.strftime('%c', time.localtime(time.time())))
print("Subway owner is...")
for i in range(int(_SUBWAY_/10)):
    for j in range(10):
        print("%3d" % _result[i*10+j], end=" ")
    print("")
