//
//  main.c
//  Algorithms
//
//  Created by wang wanli on 2020/4/27.
//  Copyright © 2020 wang wanli. All rights reserved.
//

#include <stdio.h>
#include "list_node.h"

int main(int argc, const char * argv[]) {

    int array[5] = {1, 3, 4, 6, 5};

    ListNode node = createLinkedList(array);

    printf("%d\n", node.value);

    return 0;
}
