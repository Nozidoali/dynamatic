//===- PassDetails.h - Handshake pass class details -------------*- C++ -*-===//
//
//===----------------------------------------------------------------------===//
//
// TODO
//
//===----------------------------------------------------------------------===//

#ifndef DYNAMATIC_DIALECT_HANDSHAKE_PASSDETAILS_H
#define DYNAMATIC_DIALECT_HANDSHAKE_PASSDETAILS_H

#include "circt/Dialect/Handshake/HandshakeOps.h"
#include "mlir/Pass/Pass.h"

namespace dynamatic {

#define GEN_PASS_CLASSES
#include "dynamatic/Dialect/Handshake/HandshakePasses.h.inc"

} // namespace dynamatic

#endif // DYNAMATIC_DIALECT_HANDSHAKE_PASSDETAILS_H