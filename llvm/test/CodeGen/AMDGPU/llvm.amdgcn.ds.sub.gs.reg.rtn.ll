; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx1100 -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx1100 -verify-machineinstrs < %s | FileCheck %s

declare i32 @llvm.amdgcn.ds.sub.gs.reg.rtn.i32(i32, i32 immarg)
declare i64 @llvm.amdgcn.ds.sub.gs.reg.rtn.i64(i32, i32 immarg)

define amdgpu_gs void @test_sub_32(i32 %arg) {
; CHECK-LABEL: test_sub_32:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_waitcnt_vscnt null, 0x0
; CHECK-NEXT:    ds_sub_gs_reg_rtn v[0:1], v0 offset:16 gds
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_waitcnt_vscnt null, 0x0
; CHECK-NEXT:    buffer_gl0_inv
; CHECK-NEXT:    buffer_gl1_inv
; CHECK-NEXT:    s_endpgm
  %unused = call i32 @llvm.amdgcn.ds.sub.gs.reg.rtn.i32(i32 %arg, i32 16)
  ret void
}

define amdgpu_gs void @test_sub_32_use(i32 %arg, i32 addrspace(1)* %out) {
; CHECK-LABEL: test_sub_32_use:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_waitcnt_vscnt null, 0x0
; CHECK-NEXT:    ds_sub_gs_reg_rtn v[3:4], v0 offset:16 gds
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_waitcnt_vscnt null, 0x0
; CHECK-NEXT:    buffer_gl0_inv
; CHECK-NEXT:    buffer_gl1_inv
; CHECK-NEXT:    global_store_b32 v[1:2], v3, off
; CHECK-NEXT:    s_endpgm
  %res = call i32 @llvm.amdgcn.ds.sub.gs.reg.rtn.i32(i32 %arg, i32 16)
  store i32 %res, i32 addrspace(1)* %out, align 4
  ret void
}

define amdgpu_gs void @test_sub_64(i32 %arg) {
; CHECK-LABEL: test_sub_64:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_waitcnt_vscnt null, 0x0
; CHECK-NEXT:    ds_sub_gs_reg_rtn v[0:1], v0 offset:32 gds
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_waitcnt_vscnt null, 0x0
; CHECK-NEXT:    buffer_gl0_inv
; CHECK-NEXT:    buffer_gl1_inv
; CHECK-NEXT:    s_endpgm
  %unused = call i64 @llvm.amdgcn.ds.sub.gs.reg.rtn.i64(i32 %arg, i32 32)
  ret void
}

define amdgpu_gs void @test_sub_64_use(i32 %arg, i64 addrspace(1)* %out) {
; CHECK-LABEL: test_sub_64_use:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_waitcnt_vscnt null, 0x0
; CHECK-NEXT:    ds_sub_gs_reg_rtn v[3:4], v0 offset:32 gds
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_waitcnt_vscnt null, 0x0
; CHECK-NEXT:    buffer_gl0_inv
; CHECK-NEXT:    buffer_gl1_inv
; CHECK-NEXT:    global_store_b64 v[1:2], v[3:4], off
; CHECK-NEXT:    s_endpgm
  %res = call i64 @llvm.amdgcn.ds.sub.gs.reg.rtn.i64(i32 %arg, i32 32)
  store i64 %res, i64 addrspace(1)* %out, align 4
  ret void
}

