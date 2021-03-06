//===------- bswapsi2 - Implement bswapsi2 --------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "../assembly.h"

	.syntax unified
	.text
	DEFINE_CODE_STATE

//
// extern uint32_t __bswapsi2(uint32_t);
//
// Reverse all the bytes in a 32-bit integer.
//
	.p2align 2
DEFINE_COMPILERRT_FUNCTION(__bswapsi2)
#if __ARM_ARCH < 6
    // before armv6 does not have "rev" instruction
 	eor	r1, r0, r0, ror #16
 	bic	r1, r1, #0xff0000
 	mov	r1, r1, lsr #8
 	eor	r0, r1, r0, ror #8
#else
    rev r0, r0
#endif
    JMP(lr)
END_COMPILERRT_FUNCTION(__bswapsi2)

NO_EXEC_STACK_DIRECTIVE

