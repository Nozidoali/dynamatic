//===- HandshakeToDot.h - Handshake to DOT pass -----------------*- C++ -*-===//
//
// This file declares the --handshake-to-dot pass.
//
//===----------------------------------------------------------------------===//

#ifndef DYNAMATIC_DIALECT_HANDSHAKE_HANDSHAKETODOT_H
#define DYNAMATIC_DIALECT_HANDSHAKE_HANDSHAKETODOT_H

#include "dynamatic/Support/LLVM.h"

namespace dynamatic {

std::unique_ptr<mlir::OperationPass<mlir::ModuleOp>> createHandshakeToDotPass();

} // namespace dynamatic

#endif // DYNAMATIC_DIALECT_HANDSHAKE_HANDSHAKETODOT_H
