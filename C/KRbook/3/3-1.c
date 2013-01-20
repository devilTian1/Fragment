#include <stdio.h>

int binsearch(int x, int v[], int n);

int binsearch(int x, int v[], int n) {
    int i, low, high, mid;
    low = 0;
    high = n-1;
    mid = (low + high) / 2;
    while (low <= high && v[mid] != x) {
        if (v[mid] > x) {
            high = mid-1;
        } else {
            low = mid+1;
        }
        mid = (low + high) / 2;
    }
    if (v[mid == x]) {
        return mid;
    } else {
        return -1;
    }
}

main() {
    
}
