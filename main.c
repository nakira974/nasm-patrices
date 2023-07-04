//
// Created by maxim on 2/07/2023.
//

#include <stdio.h>

extern int val_add(int x, int y);
extern int ref_add(int *x_ptr, int *y_ptr);
extern int generate_sequence();

int main(int argc, char** argv){
    int x = 10;
    int y = 20;
    int result;


    // Call the generate_sequence function
    generate_sequence();


    // Call the val_add function
    result = val_add(x, y);
    printf("val_add result: %d\n", result);

    // Call the ref_add function
    result = ref_add(&x, &y);
    printf("ref_add result: %d\n", result);


    return 0;
}