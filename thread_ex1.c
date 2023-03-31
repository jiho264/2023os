#include <stdio.h>
#include <pthread.h>
int thread_args[3] = {0, 1, 2};
void *Thread(void *arg)
{
    for (int i = 0; i < 5; i++)
        printf("thread %d: %dth iteration\n", *(int *)arg, i);
    pthread_exit(0);
}
int main()
{

    pthread_t threads[3];
    for (int i = 0; i < 3; i++)
    {
        printf("Thread Num %d Create!!\n", i);
        // void * .. i don't now that. but, it is POINTER
        pthread_create(&threads[i], NULL, (void *(*)(void *))Thread, &thread_args[i]);
    }
    pthread_exit(0);
    printf("hello world");
}
/*
https://github.com/jiho264/INU_ESE_Sophomore_2022_2/blob/main/3%EC%98%A4%ED%94%88%EC%86%8C%EC%8A%A4SW%EC%84%A4%EA%B3%84/week14/1201_0.c
*/