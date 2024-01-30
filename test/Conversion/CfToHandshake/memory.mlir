// NOTE: Assertions have been autogenerated by utils/generate-test-checks.py
// RUN: dynamatic-opt --lower-cf-to-handshake --remove-operation-names %s --split-input-file | FileCheck %s

// CHECK-LABEL:   handshake.func @simpleLoadStore(
// CHECK-SAME:                                    %[[VAL_0:.*]]: index,
// CHECK-SAME:                                    %[[VAL_1:.*]]: memref<4xi32>,
// CHECK-SAME:                                    %[[VAL_2:.*]]: none, ...) -> none attributes {argNames = ["in0", "in1", "in2"], resNames = ["out0"]} {
// CHECK:           %[[VAL_3:.*]], %[[VAL_4:.*]] = mem_controller{{\[}}%[[VAL_1]] : memref<4xi32>] (%[[VAL_5:.*]], %[[VAL_6:.*]], %[[VAL_7:.*]], %[[VAL_8:.*]]) {connectedBlocks = [0 : i32]} : (i32, index, i32, index) -> (i32, none)
// CHECK:           %[[VAL_9:.*]] = merge %[[VAL_0]] {bb = 0 : ui32} : index
// CHECK:           %[[VAL_10:.*]] = merge %[[VAL_2]] {bb = 0 : ui32} : none
// CHECK:           %[[VAL_5]] = constant %[[VAL_10]] {bb = 0 : ui32, value = 1 : i32} : i32
// CHECK:           %[[VAL_11:.*]] = constant %[[VAL_10]] {bb = 0 : ui32, value = 1 : i32} : i32
// CHECK:           %[[VAL_6]], %[[VAL_7]] = mc_store{{\[}}%[[VAL_9]]] %[[VAL_11]] {bb = 0 : ui32} : i32, index
// CHECK:           %[[VAL_8]], %[[VAL_12:.*]] = mc_load{{\[}}%[[VAL_9]]] %[[VAL_3]] {bb = 0 : ui32} : index, i32
// CHECK:           %[[VAL_13:.*]] = d_return {bb = 0 : ui32} %[[VAL_10]] : none
// CHECK:           end {bb = 0 : ui32} %[[VAL_13]], %[[VAL_4]] : none, none
// CHECK:         }
func.func @simpleLoadStore(%arg0 : index, %arg1 : memref<4xi32>) {
  %c1 = arith.constant 1 : i32
  memref.store %c1, %arg1[%arg0] {mem_interface = #handshake.mem_interface<MC>} : memref<4xi32>
  %0 = memref.load %arg1[%arg0] {mem_interface = #handshake.mem_interface<MC>} : memref<4xi32>
  return
}

// -----

// CHECK-LABEL:   handshake.func @storeMulBlocks(
// CHECK-SAME:                                   %[[VAL_0:.*]]: i1,
// CHECK-SAME:                                   %[[VAL_1:.*]]: index,
// CHECK-SAME:                                   %[[VAL_2:.*]]: memref<4xi32>,
// CHECK-SAME:                                   %[[VAL_3:.*]]: none, ...) -> none attributes {argNames = ["in0", "in1", "in2", "in3"], resNames = ["out0"]} {
// CHECK:           %[[VAL_4:.*]] = mem_controller{{\[}}%[[VAL_2]] : memref<4xi32>] (%[[VAL_5:.*]], %[[VAL_6:.*]], %[[VAL_7:.*]], %[[VAL_8:.*]], %[[VAL_9:.*]], %[[VAL_10:.*]]) {connectedBlocks = [1 : i32, 2 : i32]} : (i32, index, i32, i32, index, i32) -> none
// CHECK:           %[[VAL_11:.*]] = merge %[[VAL_0]] {bb = 0 : ui32} : i1
// CHECK:           %[[VAL_12:.*]] = merge %[[VAL_1]] {bb = 0 : ui32} : index
// CHECK:           %[[VAL_13:.*]] = merge %[[VAL_3]] {bb = 0 : ui32} : none
// CHECK:           %[[VAL_14:.*]], %[[VAL_15:.*]] = cond_br %[[VAL_11]], %[[VAL_12]] {bb = 0 : ui32} : index
// CHECK:           %[[VAL_16:.*]], %[[VAL_17:.*]] = cond_br %[[VAL_11]], %[[VAL_13]] {bb = 0 : ui32} : none
// CHECK:           %[[VAL_18:.*]], %[[VAL_19:.*]] = cond_br %[[VAL_11]], %[[VAL_12]] {bb = 0 : ui32} : index
// CHECK:           %[[VAL_20:.*]], %[[VAL_21:.*]] = cond_br %[[VAL_11]], %[[VAL_13]] {bb = 0 : ui32} : none
// CHECK:           %[[VAL_22:.*]] = merge %[[VAL_14]] {bb = 1 : ui32} : index
// CHECK:           %[[VAL_23:.*]], %[[VAL_24:.*]] = control_merge %[[VAL_16]] {bb = 1 : ui32} : none, index
// CHECK:           %[[VAL_5]] = constant %[[VAL_23]] {bb = 1 : ui32, value = 1 : i32} : i32
// CHECK:           %[[VAL_25:.*]] = constant %[[VAL_23]] {bb = 1 : ui32, value = 1 : i32} : i32
// CHECK:           %[[VAL_6]], %[[VAL_7]] = mc_store{{\[}}%[[VAL_22]]] %[[VAL_25]] {bb = 1 : ui32} : i32, index
// CHECK:           %[[VAL_26:.*]] = br %[[VAL_23]] {bb = 1 : ui32} : none
// CHECK:           %[[VAL_27:.*]] = merge %[[VAL_15]] {bb = 2 : ui32} : index
// CHECK:           %[[VAL_28:.*]], %[[VAL_29:.*]] = control_merge %[[VAL_17]] {bb = 2 : ui32} : none, index
// CHECK:           %[[VAL_8]] = constant %[[VAL_28]] {bb = 2 : ui32, value = 1 : i32} : i32
// CHECK:           %[[VAL_30:.*]] = constant %[[VAL_28]] {bb = 2 : ui32, value = 2 : i32} : i32
// CHECK:           %[[VAL_9]], %[[VAL_10]] = mc_store{{\[}}%[[VAL_27]]] %[[VAL_30]] {bb = 2 : ui32} : i32, index
// CHECK:           %[[VAL_31:.*]] = br %[[VAL_28]] {bb = 2 : ui32} : none
// CHECK:           %[[VAL_32:.*]], %[[VAL_33:.*]] = control_merge %[[VAL_31]], %[[VAL_26]] {bb = 3 : ui32} : none, index
// CHECK:           %[[VAL_34:.*]] = d_return {bb = 3 : ui32} %[[VAL_32]] : none
// CHECK:           end {bb = 3 : ui32} %[[VAL_34]], %[[VAL_4]] : none, none
// CHECK:         }
func.func @storeMulBlocks(%arg0 : i1, %arg1 : index, %arg2 : memref<4xi32>) {
  cf.cond_br %arg0, ^bb1, ^bb2
^bb1:
  %c1 = arith.constant 1 : i32
  memref.store %c1, %arg2[%arg1] {mem_interface = #handshake.mem_interface<MC>} : memref<4xi32>
  cf.br ^bb3
^bb2:
  %c2 = arith.constant 2 : i32
  memref.store %c2, %arg2[%arg1] {mem_interface = #handshake.mem_interface<MC>} : memref<4xi32>
  cf.br ^bb3
^bb3:
  return
}

// -----

// CHECK-LABEL:   handshake.func @forwardLoadToBB(
// CHECK-SAME:                                    %[[VAL_0:.*]]: i1,
// CHECK-SAME:                                    %[[VAL_1:.*]]: index,
// CHECK-SAME:                                    %[[VAL_2:.*]]: memref<4xi32>,
// CHECK-SAME:                                    %[[VAL_3:.*]]: none, ...) -> none attributes {argNames = ["in0", "in1", "in2", "in3"], resNames = ["out0"]} {
// CHECK:           %[[VAL_4:.*]], %[[VAL_5:.*]] = mem_controller{{\[}}%[[VAL_2]] : memref<4xi32>] (%[[VAL_6:.*]]) {connectedBlocks = [0 : i32]} : (index) -> (i32, none)
// CHECK:           %[[VAL_7:.*]] = merge %[[VAL_0]] {bb = 0 : ui32} : i1
// CHECK:           %[[VAL_8:.*]] = merge %[[VAL_1]] {bb = 0 : ui32} : index
// CHECK:           %[[VAL_9:.*]] = merge %[[VAL_3]] {bb = 0 : ui32} : none
// CHECK:           %[[VAL_6]], %[[VAL_10:.*]] = mc_load{{\[}}%[[VAL_8]]] %[[VAL_4]] {bb = 0 : ui32} : index, i32
// CHECK:           %[[VAL_11:.*]], %[[VAL_12:.*]] = cond_br %[[VAL_7]], %[[VAL_10]] {bb = 0 : ui32} : i32
// CHECK:           %[[VAL_13:.*]], %[[VAL_14:.*]] = cond_br %[[VAL_7]], %[[VAL_9]] {bb = 0 : ui32} : none
// CHECK:           %[[VAL_15:.*]], %[[VAL_16:.*]] = cond_br %[[VAL_7]], %[[VAL_9]] {bb = 0 : ui32} : none
// CHECK:           %[[VAL_17:.*]] = merge %[[VAL_11]] {bb = 1 : ui32} : i32
// CHECK:           %[[VAL_18:.*]], %[[VAL_19:.*]] = control_merge %[[VAL_13]] {bb = 1 : ui32} : none, index
// CHECK:           %[[VAL_20:.*]] = source {bb = 1 : ui32}
// CHECK:           %[[VAL_21:.*]] = constant %[[VAL_20]] {bb = 1 : ui32, value = 1 : i32} : i32
// CHECK:           %[[VAL_22:.*]] = arith.addi %[[VAL_17]], %[[VAL_21]] {bb = 1 : ui32} : i32
// CHECK:           %[[VAL_23:.*]] = br %[[VAL_18]] {bb = 1 : ui32} : none
// CHECK:           %[[VAL_24:.*]], %[[VAL_25:.*]] = control_merge %[[VAL_23]], %[[VAL_14]] {bb = 2 : ui32} : none, index
// CHECK:           %[[VAL_26:.*]] = d_return {bb = 2 : ui32} %[[VAL_24]] : none
// CHECK:           end {bb = 2 : ui32} %[[VAL_26]], %[[VAL_5]] : none, none
// CHECK:         }
func.func @forwardLoadToBB(%arg0 : i1, %arg1 : index, %arg2: memref<4xi32>) {
  %0 = memref.load %arg2[%arg1] {mem_interface = #handshake.mem_interface<MC>} : memref<4xi32>
  cf.cond_br %arg0, ^bb1, ^bb2
^bb1:
  %c1 = arith.constant 1 : i32
  %1 = arith.addi %0, %c1 : i32
  cf.br ^bb2
^bb2:
  return
}

// -----

// CHECK-LABEL:   handshake.func @multipleMemories(
// CHECK-SAME:                                     %[[VAL_0:.*]]: i1,
// CHECK-SAME:                                     %[[VAL_1:.*]]: memref<4xi32>, %[[VAL_2:.*]]: memref<4xi32>,
// CHECK-SAME:                                     %[[VAL_3:.*]]: none, ...) -> none attributes {argNames = ["in0", "in1", "in2", "in3"], resNames = ["out0"]} {
// CHECK:           %[[VAL_4:.*]], %[[VAL_5:.*]] = mem_controller{{\[}}%[[VAL_2]] : memref<4xi32>] (%[[VAL_6:.*]], %[[VAL_7:.*]], %[[VAL_8:.*]], %[[VAL_9:.*]]) {connectedBlocks = [1 : i32, 2 : i32]} : (index, i32, index, i32) -> (i32, none)
// CHECK:           %[[VAL_10:.*]], %[[VAL_11:.*]] = mem_controller{{\[}}%[[VAL_1]] : memref<4xi32>] (%[[VAL_12:.*]], %[[VAL_13:.*]], %[[VAL_14:.*]], %[[VAL_15:.*]]) {connectedBlocks = [1 : i32, 2 : i32]} : (i32, index, i32, index) -> (i32, none)
// CHECK:           %[[VAL_16:.*]] = merge %[[VAL_0]] {bb = 0 : ui32} : i1
// CHECK:           %[[VAL_17:.*]] = merge %[[VAL_3]] {bb = 0 : ui32} : none
// CHECK:           %[[VAL_18:.*]] = constant %[[VAL_17]] {bb = 0 : ui32, value = 0 : index} : index
// CHECK:           %[[VAL_19:.*]] = constant %[[VAL_17]] {bb = 0 : ui32, value = 0 : index} : index
// CHECK:           %[[VAL_20:.*]], %[[VAL_21:.*]] = cond_br %[[VAL_16]], %[[VAL_18]] {bb = 0 : ui32} : index
// CHECK:           %[[VAL_22:.*]], %[[VAL_23:.*]] = cond_br %[[VAL_16]], %[[VAL_17]] {bb = 0 : ui32} : none
// CHECK:           %[[VAL_24:.*]], %[[VAL_25:.*]] = cond_br %[[VAL_16]], %[[VAL_19]] {bb = 0 : ui32} : index
// CHECK:           %[[VAL_26:.*]], %[[VAL_27:.*]] = cond_br %[[VAL_16]], %[[VAL_17]] {bb = 0 : ui32} : none
// CHECK:           %[[VAL_28:.*]] = merge %[[VAL_20]] {bb = 1 : ui32} : index
// CHECK:           %[[VAL_29:.*]], %[[VAL_30:.*]] = control_merge %[[VAL_22]] {bb = 1 : ui32} : none, index
// CHECK:           %[[VAL_12]] = constant %[[VAL_29]] {bb = 1 : ui32, value = 1 : i32} : i32
// CHECK:           %[[VAL_6]], %[[VAL_31:.*]] = mc_load{{\[}}%[[VAL_28]]] %[[VAL_4]] {bb = 1 : ui32} : index, i32
// CHECK:           %[[VAL_13]], %[[VAL_14]] = mc_store{{\[}}%[[VAL_28]]] %[[VAL_31]] {bb = 1 : ui32} : i32, index
// CHECK:           %[[VAL_32:.*]] = d_return {bb = 1 : ui32} %[[VAL_29]] : none
// CHECK:           %[[VAL_33:.*]] = merge %[[VAL_25]] {bb = 2 : ui32} : index
// CHECK:           %[[VAL_34:.*]], %[[VAL_35:.*]] = control_merge %[[VAL_23]] {bb = 2 : ui32} : none, index
// CHECK:           %[[VAL_7]] = constant %[[VAL_34]] {bb = 2 : ui32, value = 1 : i32} : i32
// CHECK:           %[[VAL_15]], %[[VAL_36:.*]] = mc_load{{\[}}%[[VAL_33]]] %[[VAL_10]] {bb = 2 : ui32} : index, i32
// CHECK:           %[[VAL_8]], %[[VAL_9]] = mc_store{{\[}}%[[VAL_33]]] %[[VAL_36]] {bb = 2 : ui32} : i32, index
// CHECK:           %[[VAL_37:.*]] = d_return {bb = 2 : ui32} %[[VAL_34]] : none
// CHECK:           %[[VAL_38:.*]] = merge %[[VAL_32]], %[[VAL_37]] {bb = 3 : ui32} : none
// CHECK:           end {bb = 3 : ui32} %[[VAL_38]], %[[VAL_5]], %[[VAL_11]] : none, none, none
// CHECK:         }
func.func @multipleMemories(%arg0 : i1, %arg1: memref<4xi32>, %arg2: memref<4xi32>) {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 0 : index
  cf.cond_br %arg0, ^bb1, ^bb2
^bb1:
  %1 = memref.load %arg2[%c0] {mem_interface = #handshake.mem_interface<MC>} : memref<4xi32>
  memref.store %1, %arg1[%c0] {mem_interface = #handshake.mem_interface<MC>} : memref<4xi32>
  return
^bb2:
  %2 = memref.load %arg1[%c1] {mem_interface = #handshake.mem_interface<MC>} : memref<4xi32>
  memref.store %2, %arg2[%c1] {mem_interface = #handshake.mem_interface<MC>} : memref<4xi32>
  return
}