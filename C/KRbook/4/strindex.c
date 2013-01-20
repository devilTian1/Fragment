int strindex(char line[], char search[]) {
    int i, j, k;

    for (i = 0; line[i] != '\0'; i++) {
        for (j=i, k=0; search[k] != '\0' && line[j] == search[k]; k++, j++) {
            ;
        }
        if (k>0 && search[k] == '\0') {
            return i;
        }
    }
    return -1;
}
