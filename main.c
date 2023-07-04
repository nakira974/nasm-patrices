//
// Created by maxim on 2/07/2023.
//

#include <stdio.h>

extern int val_add(int x, int y);
extern int ref_add(int *x_ptr, int *y_ptr);
extern void* generate_sequence(int elements_size);

int main(int argc, char** argv){
    int x = 10;
    int y = 20;
    int result;
    void * generic_sequence;
    int * integers_sequence;

    // Call the generate_sequence function
    generic_sequence = generate_sequence(sizeof(int));
    integers_sequence = (int *) generic_sequence;
    for(int i = integers_sequence[0] -1; i >= 0; i--){
        printf("%d\n", integers_sequence[i+1]);
    }

    // Call the val_add function
    result = val_add(x, y);
    printf("val_add result: %d\n", result);

    // Call the ref_add function
    result = ref_add(&x, &y);
    printf("ref_add result: %d\n", result);


    return 0;
}