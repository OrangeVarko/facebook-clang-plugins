(*
 *  Copyright (c) 2014, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 *)

open Clang_ast_t

#define s(x) #x

let get_decl_kind_string = function
#define DECL(DERIVED, BASE) | DERIVED@@Decl (@DERIVED@_decl_tuple) -> s(DERIVED) ^ "Decl"
#define ABSTRACT_DECL(DECL)
#include <clang/AST/DeclNodes.inc>

let get_decl_tuple = function
#define DECL(DERIVED, BASE) | DERIVED@@Decl (@DERIVED@_decl_tuple) -> (decl_tuple)
#define ABSTRACT_DECL(DECL)
#include <clang/AST/DeclNodes.inc>

let update_decl_tuple __f = function
#define DECL(DERIVED, BASE) | DERIVED@@Decl (@DERIVED@_decl_tuple) -> \
    let (decl_tuple) = __f (decl_tuple) in DERIVED@@Decl (@DERIVED@_decl_tuple)
#define ABSTRACT_DECL(DECL)
#include <clang/AST/DeclNodes.inc>


let get_decl_context_tuple = function
#define DECL(DERIVED, BASE)
#define ABSTRACT_DECL(DECL)
#define MY_DECL_CONTEXT(DERIVED) | DERIVED@@Decl (@DERIVED@_decl_tuple) -> Some (decl_context_tuple)
(* skipping Function and ObjCMethod *)
#define TAG(DERIVED, BASE) MY_DECL_CONTEXT(DERIVED)
#define OBJCCONTAINER(DERIVED, BASE) MY_DECL_CONTEXT(DERIVED)
#define CAPTURED(DERIVED, BASE) MY_DECL_CONTEXT(DERIVED)
#define LINKAGESPEC(DERIVED, BASE) MY_DECL_CONTEXT(DERIVED)
#define NAMESPACE(DERIVED, BASE) MY_DECL_CONTEXT(DERIVED)
#define TRANSLATIONUNIT(DERIVED, BASE) MY_DECL_CONTEXT(DERIVED)
#include <clang/AST/DeclNodes.inc>
#undef MY_DECL_CONTEXT
| _ -> None

let update_decl_context_tuple __f = function
#define DECL(DERIVED, BASE)
#define ABSTRACT_DECL(DECL)
#define MY_DECL_CONTEXT(DERIVED) | DERIVED@@Decl (@DERIVED@_decl_tuple) -> \
    let (decl_context_tuple) = __f (decl_context_tuple) in DERIVED@@Decl (@DERIVED@_decl_tuple)
(* skipping Function and ObjCMethod *)
#define TAG(DERIVED, BASE) MY_DECL_CONTEXT(DERIVED)
#define OBJCCONTAINER(DERIVED, BASE) MY_DECL_CONTEXT(DERIVED)
#define CAPTURED(DERIVED, BASE) MY_DECL_CONTEXT(DERIVED)
#define LINKAGESPEC(DERIVED, BASE) MY_DECL_CONTEXT(DERIVED)
#define NAMESPACE(DERIVED, BASE) MY_DECL_CONTEXT(DERIVED)
#define TRANSLATIONUNIT(DERIVED, BASE) MY_DECL_CONTEXT(DERIVED)
#include <clang/AST/DeclNodes.inc>
#undef MY_DECL_CONTEXT
| x -> x


let get_named_decl_tuple = function
#define DECL(DERIVED, BASE)
#define ABSTRACT_DECL(DECL)
#define NAMED(DERIVED, BASE) | DERIVED@@Decl (@DERIVED@_decl_tuple) -> Some (named_decl_tuple)
#include <clang/AST/DeclNodes.inc>
| _ -> None

let update_named_decl_tuple __f = function
#define DECL(DERIVED, BASE)
#define ABSTRACT_DECL(DECL)
#define NAMED(DERIVED, BASE) | DERIVED@@Decl (@DERIVED@_decl_tuple) -> \
    let (named_decl_tuple) = __f (named_decl_tuple) in DERIVED@@Decl (@DERIVED@_decl_tuple)
#include <clang/AST/DeclNodes.inc>
| x -> x


let get_type_decl_tuple = function
#define DECL(DERIVED, BASE)
#define ABSTRACT_DECL(DECL)
#define TYPE(DERIVED, BASE) | DERIVED@@Decl (@DERIVED@_decl_tuple) -> Some (type_decl_tuple)
#include <clang/AST/DeclNodes.inc>
| _ -> None

let update_type_decl_tuple __f = function
#define DECL(DERIVED, BASE)
#define ABSTRACT_DECL(DECL)
#define TYPE(DERIVED, BASE) | DERIVED@@Decl (@DERIVED@_decl_tuple) -> \
    let (type_decl_tuple) = __f (type_decl_tuple) in DERIVED@@Decl (@DERIVED@_decl_tuple)
#include <clang/AST/DeclNodes.inc>
| x -> x


let get_tag_decl_tuple = function
#define DECL(DERIVED, BASE)
#define ABSTRACT_DECL(DECL)
#define TAG(DERIVED, BASE) | DERIVED@@Decl (@DERIVED@_decl_tuple) -> Some (tag_decl_tuple)
#include <clang/AST/DeclNodes.inc>
| _ -> None

let update_tag_decl_tuple __f = function
#define DECL(DERIVED, BASE)
#define ABSTRACT_DECL(DECL)
#define TAG(DERIVED, BASE) | DERIVED@@Decl (@DERIVED@_decl_tuple) -> \
    let (tag_decl_tuple) = __f (tag_decl_tuple) in DERIVED@@Decl (@DERIVED@_decl_tuple)
#include <clang/AST/DeclNodes.inc>
| x -> x


let get_stmt_kind_string = function
#define STMT(CLASS, PARENT) | CLASS (@CLASS@_tuple) -> s(CLASS)
#define ABSTRACT_STMT(STMT)
#include <clang/AST/StmtNodes.inc>

let get_stmt_tuple = function
#define STMT(CLASS, PARENT) | CLASS (@CLASS@_tuple) -> (stmt_tuple)
#define ABSTRACT_STMT(STMT)
#include <clang/AST/StmtNodes.inc>

let update_stmt_tuple __f = function
#define STMT(CLASS, PARENT) | CLASS (@CLASS@_tuple) -> \
    let (stmt_tuple) = __f (stmt_tuple) in CLASS (@CLASS@_tuple)
#define ABSTRACT_STMT(STMT)
#include <clang/AST/StmtNodes.inc>


let get_expr_tuple = function
#define STMT(CLASS, PARENT)
#define EXPR(CLASS, PARENT) | CLASS (@CLASS@_tuple) -> Some (expr_tuple)
#define ABSTRACT_STMT(STMT)
#include <clang/AST/StmtNodes.inc>
| _ -> None

let update_expr_tuple __f = function
#define STMT(CLASS, PARENT)
#define EXPR(CLASS, PARENT) | CLASS (@CLASS@_tuple) -> \
    let (expr_tuple) = __f (expr_tuple) in CLASS (@CLASS@_tuple)
#define ABSTRACT_STMT(STMT)
#include <clang/AST/StmtNodes.inc>
| x -> x

let get_type_tuple = function
#define TYPE(DERIVED, BASE) | DERIVED@@Type (@DERIVED@_type_tuple) -> (type_tuple)
#define ABSTRACT_TYPE(DERIVED, BASE)
TYPE(None, Type) (*  special case for nullptr type *)
#include <clang/AST/TypeNodes.def>
