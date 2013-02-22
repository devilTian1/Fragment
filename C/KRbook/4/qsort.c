#include <stdio.h>

void qsort(int v[], int left, int right);
void qsort(int v[], int left, int right) {
    int i, last;
    void swap(int v[], int i, int j);

    if (left >= right) {
        return ;
    }
    swap(v, left, (left + right)/2);
    last = left;
    for (i = left+1; i <= right; i++) {
        if (v[i] < v[left]) {
            swap(v, ++last, i);
        }
    }
    swap(v, left, last);
    qsort(v, left, last-1);
    qsort(v, last+1, right);
}

void swap(int v[], int i, int j) {
    int temp;
    temp = v[i];
    v[i] = v[j];
    v[j] = temp;
}

main() {
    int x[] = {3, 1, 4 ,1, 5, 9, 2, 6, 7};
    int i = 0;
    qsort(x, 0, 8);
    do {
        printf("%d, ", x[i]);
    } while ((++i) != 9);
}
