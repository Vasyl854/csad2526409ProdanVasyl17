```cpp
#include "math_operations.h"
#include <gtest/gtest.h>

TEST(AddTest, HandlesPositiveNumbers) {
    EXPECT_EQ(add(1, 2), 3);
    EXPECT_EQ(add(10, 20), 30);
}

TEST(AddTest, HandlesNegativeNumbers) {
    EXPECT_EQ(add(-1, -2), -3);
    EXPECT_EQ(add(-5, 3), -2);
}

TEST(AddTest, HandlesZero) {
    EXPECT_EQ(add(0, 0), 0);
    EXPECT_EQ(add(0, 5), 5);
    EXPECT_EQ(add(5, 0), 5);
}

TEST(AddTest, HandlesLargeNumbers) {
    EXPECT_EQ(add(1000000, 2000000), 3000000);
}
``` 
