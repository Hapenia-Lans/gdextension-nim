## ***********************************************************************
##   gdnative_interface.h
## ***********************************************************************
##                        This file is part of:
##                            GODOT ENGINE
##                       https://godotengine.org
## ***********************************************************************
##  Copyright (c) 2007-2022 Juan Linietsky, Ariel Manzur.
##  Copyright (c) 2014-2022 Godot Engine contributors (cf. AUTHORS.md).
##
##  Permission is hereby granted, free of charge, to any person obtaining
##  a copy of this software and associated documentation files (the
##  "Software"), to deal in the Software without restriction, including
##  without limitation the rights to use, copy, modify, merge, publish,
##  distribute, sublicense, and/or sell copies of the Software, and to
##  permit persons to whom the Software is furnished to do so, subject to
##  the following conditions:
##
##  The above copyright notice and this permission notice shall be
##  included in all copies or substantial portions of the Software.
##
##  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
##  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
##  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
##  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
##  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
##  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
##  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
## ***********************************************************************

##  This is a C class header, you can copy it and use it directly in your own binders.
##  Together with the JSON file, you should be able to generate any binder.
##

type
  char32_t* = uint32
  char16_t* = uint16

##  VARIANT TYPES

type                          ##  comparison
  GDNativeVariantType* {.size: sizeof(cint).} = enum
    GDNATIVE_VARIANT_TYPE_NIL, ##   atomic types
    GDNATIVE_VARIANT_TYPE_BOOL, GDNATIVE_VARIANT_TYPE_INT,
    GDNATIVE_VARIANT_TYPE_FLOAT, GDNATIVE_VARIANT_TYPE_STRING, ##  math types
    GDNATIVE_VARIANT_TYPE_VECTOR2, GDNATIVE_VARIANT_TYPE_VECTOR2I,
    GDNATIVE_VARIANT_TYPE_RECT2, GDNATIVE_VARIANT_TYPE_RECT2I,
    GDNATIVE_VARIANT_TYPE_VECTOR3, GDNATIVE_VARIANT_TYPE_VECTOR3I,
    GDNATIVE_VARIANT_TYPE_TRANSFORM2D, GDNATIVE_VARIANT_TYPE_VECTOR4,
    GDNATIVE_VARIANT_TYPE_VECTOR4I, GDNATIVE_VARIANT_TYPE_PLANE,
    GDNATIVE_VARIANT_TYPE_QUATERNION, GDNATIVE_VARIANT_TYPE_AABB,
    GDNATIVE_VARIANT_TYPE_BASIS, GDNATIVE_VARIANT_TYPE_TRANSFORM3D, GDNATIVE_VARIANT_TYPE_PROJECTION, ##  misc types
    GDNATIVE_VARIANT_TYPE_COLOR, GDNATIVE_VARIANT_TYPE_STRING_NAME,
    GDNATIVE_VARIANT_TYPE_NODE_PATH, GDNATIVE_VARIANT_TYPE_RID,
    GDNATIVE_VARIANT_TYPE_OBJECT, GDNATIVE_VARIANT_TYPE_CALLABLE,
    GDNATIVE_VARIANT_TYPE_SIGNAL, GDNATIVE_VARIANT_TYPE_DICTIONARY, GDNATIVE_VARIANT_TYPE_ARRAY, ##  typed arrays
    GDNATIVE_VARIANT_TYPE_PACKED_BYTE_ARRAY,
    GDNATIVE_VARIANT_TYPE_PACKED_INT32_ARRAY,
    GDNATIVE_VARIANT_TYPE_PACKED_INT64_ARRAY,
    GDNATIVE_VARIANT_TYPE_PACKED_FLOAT32_ARRAY,
    GDNATIVE_VARIANT_TYPE_PACKED_FLOAT64_ARRAY,
    GDNATIVE_VARIANT_TYPE_PACKED_STRING_ARRAY,
    GDNATIVE_VARIANT_TYPE_PACKED_VECTOR2_ARRAY,
    GDNATIVE_VARIANT_TYPE_PACKED_VECTOR3_ARRAY,
    GDNATIVE_VARIANT_TYPE_PACKED_COLOR_ARRAY, GDNATIVE_VARIANT_TYPE_VARIANT_MAX
  GDNativeVariantOperator* {.size: sizeof(cint).} = enum
    GDNATIVE_VARIANT_OP_EQUAL, GDNATIVE_VARIANT_OP_NOT_EQUAL,
    GDNATIVE_VARIANT_OP_LESS, GDNATIVE_VARIANT_OP_LESS_EQUAL,
    GDNATIVE_VARIANT_OP_GREATER, GDNATIVE_VARIANT_OP_GREATER_EQUAL, ##  mathematic
    GDNATIVE_VARIANT_OP_ADD, GDNATIVE_VARIANT_OP_SUBTRACT,
    GDNATIVE_VARIANT_OP_MULTIPLY, GDNATIVE_VARIANT_OP_DIVIDE,
    GDNATIVE_VARIANT_OP_NEGATE, GDNATIVE_VARIANT_OP_POSITIVE,
    GDNATIVE_VARIANT_OP_MODULE, GDNATIVE_VARIANT_OP_POWER, ##  bitwise
    GDNATIVE_VARIANT_OP_SHIFT_LEFT, GDNATIVE_VARIANT_OP_SHIFT_RIGHT,
    GDNATIVE_VARIANT_OP_BIT_AND, GDNATIVE_VARIANT_OP_BIT_OR,
    GDNATIVE_VARIANT_OP_BIT_XOR, GDNATIVE_VARIANT_OP_BIT_NEGATE, ##  logic
    GDNATIVE_VARIANT_OP_AND, GDNATIVE_VARIANT_OP_OR, GDNATIVE_VARIANT_OP_XOR, GDNATIVE_VARIANT_OP_NOT, ##  containment
    GDNATIVE_VARIANT_OP_IN, GDNATIVE_VARIANT_OP_MAX
  GDNativeVariantPtr* = pointer
  GDNativeStringNamePtr* = pointer
  GDNativeStringPtr* = pointer
  GDNativeObjectPtr* = pointer
  GDNativeTypePtr* = pointer
  GDNativeExtensionPtr* = pointer
  GDNativeMethodBindPtr* = pointer
  GDNativeInt* = int64
  GDNativeBool* = uint8
  GDObjectInstanceID* = uint64



##  VARIANT DATA I/O

type
  GDNativeCallErrorType* {.size: sizeof(cint).} = enum
    GDNATIVE_CALL_OK, GDNATIVE_CALL_ERROR_INVALID_METHOD, GDNATIVE_CALL_ERROR_INVALID_ARGUMENT, ##  expected is variant type
    GDNATIVE_CALL_ERROR_TOO_MANY_ARGUMENTS, ##  expected is number of arguments
    GDNATIVE_CALL_ERROR_TOO_FEW_ARGUMENTS, ##   expected is number of arguments
    GDNATIVE_CALL_ERROR_INSTANCE_IS_NULL, GDNATIVE_CALL_ERROR_METHOD_NOT_CONST ##  used for const call
  GDNativeCallError* {.importc: "GDNativeCallError",
                      header: "gdnative_interface.h", bycopy.} = object
    error* {.importc: "error".}: GDNativeCallErrorType
    argument* {.importc: "argument".}: int32
    expected* {.importc: "expected".}: int32

  GDNativeVariantFromTypeConstructorFunc* = proc (a1: GDNativeVariantPtr;
      a2: GDNativeTypePtr) {.cdecl.}
  GDNativeTypeFromVariantConstructorFunc* = proc (a1: GDNativeTypePtr;
      a2: GDNativeVariantPtr) {.cdecl.}
  GDNativePtrOperatorEvaluator* = proc (p_left: GDNativeTypePtr;
                                     p_right: GDNativeTypePtr;
                                     r_result: GDNativeTypePtr) {.cdecl.}
  GDNativePtrBuiltInMethod* = proc (p_base: GDNativeTypePtr;
                                 p_args: ptr GDNativeTypePtr;
                                 r_return: GDNativeTypePtr; p_argument_count: cint) {.
      cdecl.}
  GDNativePtrConstructor* = proc (p_base: GDNativeTypePtr;
                               p_args: ptr GDNativeTypePtr) {.cdecl.}
  GDNativePtrDestructor* = proc (p_base: GDNativeTypePtr) {.cdecl.}
  GDNativePtrSetter* = proc (p_base: GDNativeTypePtr; p_value: GDNativeTypePtr) {.cdecl.}
  GDNativePtrGetter* = proc (p_base: GDNativeTypePtr; r_value: GDNativeTypePtr) {.cdecl.}
  GDNativePtrIndexedSetter* = proc (p_base: GDNativeTypePtr; p_index: GDNativeInt;
                                 p_value: GDNativeTypePtr) {.cdecl.}
  GDNativePtrIndexedGetter* = proc (p_base: GDNativeTypePtr; p_index: GDNativeInt;
                                 r_value: GDNativeTypePtr) {.cdecl.}
  GDNativePtrKeyedSetter* = proc (p_base: GDNativeTypePtr; p_key: GDNativeTypePtr;
                               p_value: GDNativeTypePtr) {.cdecl.}
  GDNativePtrKeyedGetter* = proc (p_base: GDNativeTypePtr; p_key: GDNativeTypePtr;
                               r_value: GDNativeTypePtr) {.cdecl.}
  GDNativePtrKeyedChecker* = proc (p_base: GDNativeVariantPtr;
                                p_key: GDNativeVariantPtr): uint32 {.cdecl.}
  GDNativePtrUtilityFunction* = proc (r_return: GDNativeTypePtr;
                                   p_arguments: ptr GDNativeTypePtr;
                                   p_argument_count: cint) {.cdecl.}
  GDNativeClassConstructor* = proc (): GDNativeObjectPtr {.cdecl.}
  GDNativeInstanceBindingCreateCallback* = proc (p_token: pointer;
      p_instance: pointer): pointer {.cdecl.}
  GDNativeInstanceBindingFreeCallback* = proc (p_token: pointer; p_instance: pointer;
      p_binding: pointer) {.cdecl.}
  GDNativeInstanceBindingReferenceCallback* = proc (p_token: pointer;
      p_binding: pointer; p_reference: GDNativeBool): GDNativeBool {.cdecl.}
  GDNativeInstanceBindingCallbacks* {.importc: "GDNativeInstanceBindingCallbacks",
                                     header: "gdnative_interface.h", bycopy.} = object
    create_callback* {.importc: "create_callback".}: GDNativeInstanceBindingCreateCallback
    free_callback* {.importc: "free_callback".}: GDNativeInstanceBindingFreeCallback
    reference_callback* {.importc: "reference_callback".}: GDNativeInstanceBindingReferenceCallback



##  EXTENSION CLASSES

type
  GDExtensionClassInstancePtr* = pointer
  GDNativeExtensionClassSet* = proc (p_instance: GDExtensionClassInstancePtr;
                                  p_name: GDNativeStringNamePtr;
                                  p_value: GDNativeVariantPtr): GDNativeBool {.
      cdecl.}
  GDNativeExtensionClassGet* = proc (p_instance: GDExtensionClassInstancePtr;
                                  p_name: GDNativeStringNamePtr;
                                  r_ret: GDNativeVariantPtr): GDNativeBool {.cdecl.}
  GDNativeExtensionClassGetRID* = proc (p_instance: GDExtensionClassInstancePtr): uint64 {.
      cdecl.}
  GDNativePropertyInfo* {.importc: "GDNativePropertyInfo",
                         header: "gdnative_interface.h", bycopy.} = object
    `type`* {.importc: "type".}: uint32
    name* {.importc: "name".}: cstring
    class_name* {.importc: "class_name".}: cstring
    hint* {.importc: "hint".}: uint32
    hint_string* {.importc: "hint_string".}: cstring
    usage* {.importc: "usage".}: uint32

  GDNativeMethodInfo* {.importc: "GDNativeMethodInfo",
                       header: "gdnative_interface.h", bycopy.} = object
    name* {.importc: "name".}: cstring
    return_value* {.importc: "return_value".}: GDNativePropertyInfo
    flags* {.importc: "flags".}: uint32 ##  From GDNativeExtensionClassMethodFlags
    id* {.importc: "id".}: int32
    arguments* {.importc: "arguments".}: ptr GDNativePropertyInfo
    argument_count* {.importc: "argument_count".}: uint32
    default_arguments* {.importc: "default_arguments".}: GDNativeVariantPtr
    default_argument_count* {.importc: "default_argument_count".}: uint32

  GDNativeExtensionClassGetPropertyList* = proc (
      p_instance: GDExtensionClassInstancePtr; r_count: ptr uint32): ptr GDNativePropertyInfo {.
      cdecl.}
  GDNativeExtensionClassFreePropertyList* = proc (
      p_instance: GDExtensionClassInstancePtr; p_list: ptr GDNativePropertyInfo) {.
      cdecl.}
  GDNativeExtensionClassNotification* = proc (
      p_instance: GDExtensionClassInstancePtr; p_what: int32) {.cdecl.}
  GDNativeExtensionClassToString* = proc (p_instance: GDExtensionClassInstancePtr;
                                       p_out: GDNativeStringPtr) {.cdecl.}
  GDNativeExtensionClassReference* = proc (p_instance: GDExtensionClassInstancePtr) {.
      cdecl.}
  GDNativeExtensionClassUnreference* = proc (
      p_instance: GDExtensionClassInstancePtr) {.cdecl.}
  GDNativeExtensionClassCallVirtual* = proc (
      p_instance: GDExtensionClassInstancePtr; p_args: ptr GDNativeTypePtr;
      r_ret: GDNativeTypePtr) {.cdecl.}
  GDNativeExtensionClassCreateInstance* = proc (p_userdata: pointer): GDNativeObjectPtr {.
      cdecl.}
  GDNativeExtensionClassFreeInstance* = proc (p_userdata: pointer;
      p_instance: GDExtensionClassInstancePtr) {.cdecl.}
  GDNativeExtensionClassObjectInstance* = proc (
      p_instance: GDExtensionClassInstancePtr;
      p_object_instance: GDNativeObjectPtr) {.cdecl.}
  GDNativeExtensionClassGetVirtual* = proc (p_userdata: pointer; p_name: cstring): GDNativeExtensionClassCallVirtual {.
      cdecl.}
  GDNativeExtensionClassCreationInfo* {.importc: "GDNativeExtensionClassCreationInfo",
                                       header: "gdnative_interface.h", bycopy.} = object
    set_func* {.importc: "set_func".}: GDNativeExtensionClassSet
    get_func* {.importc: "get_func".}: GDNativeExtensionClassGet
    get_property_list_func* {.importc: "get_property_list_func".}: GDNativeExtensionClassGetPropertyList
    free_property_list_func* {.importc: "free_property_list_func".}: GDNativeExtensionClassFreePropertyList
    notification_func* {.importc: "notification_func".}: GDNativeExtensionClassNotification
    to_string_func* {.importc: "to_string_func".}: GDNativeExtensionClassToString
    reference_func* {.importc: "reference_func".}: GDNativeExtensionClassReference
    unreference_func* {.importc: "unreference_func".}: GDNativeExtensionClassUnreference
    create_instance_func* {.importc: "create_instance_func".}: GDNativeExtensionClassCreateInstance ##  this one is mandatory
    free_instance_func* {.importc: "free_instance_func".}: GDNativeExtensionClassFreeInstance ##  this one is mandatory
    get_virtual_func* {.importc: "get_virtual_func".}: GDNativeExtensionClassGetVirtual
    get_rid_func* {.importc: "get_rid_func".}: GDNativeExtensionClassGetRID
    class_userdata* {.importc: "class_userdata".}: pointer

  GDNativeExtensionClassLibraryPtr* = pointer

##  Method

type
  GDNativeExtensionClassMethodFlags* {.size: sizeof(cint).} = enum
    GDNATIVE_EXTENSION_METHOD_FLAG_NORMAL = 1,
    GDNATIVE_EXTENSION_METHOD_FLAG_EDITOR = 2,
    GDNATIVE_EXTENSION_METHOD_FLAG_CONST = 4,
    GDNATIVE_EXTENSION_METHOD_FLAG_VIRTUAL = 8,
    GDNATIVE_EXTENSION_METHOD_FLAG_VARARG = 16,
    GDNATIVE_EXTENSION_METHOD_FLAG_STATIC = 32
  GDNativeExtensionClassMethodArgumentMetadata* {.size: sizeof(cint).} = enum
    GDNATIVE_EXTENSION_METHOD_ARGUMENT_METADATA_NONE,
    GDNATIVE_EXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_INT8,
    GDNATIVE_EXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_INT16,
    GDNATIVE_EXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_INT32,
    GDNATIVE_EXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_INT64,
    GDNATIVE_EXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_UINT8,
    GDNATIVE_EXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_UINT16,
    GDNATIVE_EXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_UINT32,
    GDNATIVE_EXTENSION_METHOD_ARGUMENT_METADATA_INT_IS_UINT64,
    GDNATIVE_EXTENSION_METHOD_ARGUMENT_METADATA_REAL_IS_FLOAT,
    GDNATIVE_EXTENSION_METHOD_ARGUMENT_METADATA_REAL_IS_DOUBLE
  GDNativeExtensionClassMethodCall* = proc (method_userdata: pointer;
      p_instance: GDExtensionClassInstancePtr; p_args: ptr GDNativeVariantPtr;
      p_argument_count: GDNativeInt; r_return: GDNativeVariantPtr;
      r_error: ptr GDNativeCallError) {.cdecl.}
  GDNativeExtensionClassMethodPtrCall* = proc (method_userdata: pointer;
      p_instance: GDExtensionClassInstancePtr; p_args: ptr GDNativeTypePtr;
      r_ret: GDNativeTypePtr) {.cdecl.}

const
  GDNATIVE_EXTENSION_METHOD_FLAGS_DEFAULT* = GDNATIVE_EXTENSION_METHOD_FLAG_NORMAL


##  passing -1 as argument in the following functions refers to the return type

type
  GDNativeExtensionClassMethodGetArgumentType* = proc (p_method_userdata: pointer;
      p_argument: int32): GDNativeVariantType {.cdecl.}
  GDNativeExtensionClassMethodGetArgumentInfo* = proc (p_method_userdata: pointer;
      p_argument: int32; r_info: ptr GDNativePropertyInfo) {.cdecl.}
  GDNativeExtensionClassMethodGetArgumentMetadata* = proc (
      p_method_userdata: pointer; p_argument: int32): GDNativeExtensionClassMethodArgumentMetadata {.
      cdecl.}
  GDNativeExtensionClassMethodInfo* {.importc: "GDNativeExtensionClassMethodInfo",
                                     header: "gdnative_interface.h", bycopy.} = object
    name* {.importc: "name".}: cstring
    method_userdata* {.importc: "method_userdata".}: pointer
    call_func* {.importc: "call_func".}: GDNativeExtensionClassMethodCall
    ptrcall_func* {.importc: "ptrcall_func".}: GDNativeExtensionClassMethodPtrCall
    method_flags* {.importc: "method_flags".}: uint32 ##  GDNativeExtensionClassMethodFlags
    argument_count* {.importc: "argument_count".}: uint32
    has_return_value* {.importc: "has_return_value".}: GDNativeBool
    get_argument_type_func* {.importc: "get_argument_type_func".}: GDNativeExtensionClassMethodGetArgumentType
    get_argument_info_func* {.importc: "get_argument_info_func".}: GDNativeExtensionClassMethodGetArgumentInfo ##  name and hint information for the argument can be omitted in release builds. Class name should always be present if it applies.
    get_argument_metadata_func* {.importc: "get_argument_metadata_func".}: GDNativeExtensionClassMethodGetArgumentMetadata
    default_argument_count* {.importc: "default_argument_count".}: uint32
    default_arguments* {.importc: "default_arguments".}: ptr GDNativeVariantPtr


##  SCRIPT INSTANCE EXTENSION

type
  GDNativeExtensionScriptInstanceDataPtr* = pointer

##  Pointer to custom ScriptInstance native implementation

type
  GDNativeExtensionScriptInstanceSet* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr;
      p_name: GDNativeStringNamePtr; p_value: GDNativeVariantPtr): GDNativeBool {.
      cdecl.}
  GDNativeExtensionScriptInstanceGet* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr;
      p_name: GDNativeStringNamePtr; r_ret: GDNativeVariantPtr): GDNativeBool {.cdecl.}
  GDNativeExtensionScriptInstanceGetPropertyList* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr; r_count: ptr uint32): ptr GDNativePropertyInfo {.
      cdecl.}
  GDNativeExtensionScriptInstanceFreePropertyList* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr;
      p_list: ptr GDNativePropertyInfo) {.cdecl.}
  GDNativeExtensionScriptInstanceGetPropertyType* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr;
      p_name: GDNativeStringNamePtr; r_is_valid: ptr GDNativeBool): GDNativeVariantType {.
      cdecl.}
  GDNativeExtensionScriptInstanceGetOwner* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr): GDNativeObjectPtr {.
      cdecl.}
  GDNativeExtensionScriptInstancePropertyStateAdd* = proc (
      p_name: GDNativeStringNamePtr; p_value: GDNativeVariantPtr;
      p_userdata: pointer) {.cdecl.}
  GDNativeExtensionScriptInstanceGetPropertyState* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr;
      p_add_func: GDNativeExtensionScriptInstancePropertyStateAdd;
      p_userdata: pointer) {.cdecl.}
  GDNativeExtensionScriptInstanceGetMethodList* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr; r_count: ptr uint32): ptr GDNativeMethodInfo {.
      cdecl.}
  GDNativeExtensionScriptInstanceFreeMethodList* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr;
      p_list: ptr GDNativeMethodInfo) {.cdecl.}
  GDNativeExtensionScriptInstanceHasMethod* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr;
      p_name: GDNativeStringNamePtr): GDNativeBool {.cdecl.}
  GDNativeExtensionScriptInstanceCall* = proc (
      p_self: GDNativeExtensionScriptInstanceDataPtr;
      p_method: GDNativeStringNamePtr; p_args: ptr GDNativeVariantPtr;
      p_argument_count: GDNativeInt; r_return: GDNativeVariantPtr;
      r_error: ptr GDNativeCallError) {.cdecl.}
  GDNativeExtensionScriptInstanceNotification* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr; p_what: int32) {.cdecl.}
  GDNativeExtensionScriptInstanceToString* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr;
      r_is_valid: ptr GDNativeBool): cstring {.cdecl.}
  GDNativeExtensionScriptInstanceRefCountIncremented* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr) {.cdecl.}
  GDNativeExtensionScriptInstanceRefCountDecremented* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr): GDNativeBool {.cdecl.}
  GDNativeExtensionScriptInstanceGetScript* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr): GDNativeObjectPtr {.
      cdecl.}
  GDNativeExtensionScriptInstanceIsPlaceholder* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr): GDNativeBool {.cdecl.}
  GDNativeExtensionScriptLanguagePtr* = pointer
  GDNativeExtensionScriptInstanceGetLanguage* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr): GDNativeExtensionScriptLanguagePtr {.
      cdecl.}
  GDNativeExtensionScriptInstanceFree* = proc (
      p_instance: GDNativeExtensionScriptInstanceDataPtr) {.cdecl.}
  GDNativeScriptInstancePtr* = pointer

##  Pointer to ScriptInstance.

type
  GDNativeExtensionScriptInstanceInfo* {.importc: "GDNativeExtensionScriptInstanceInfo",
                                        header: "gdnative_interface.h", bycopy.} = object
    set_func* {.importc: "set_func".}: GDNativeExtensionScriptInstanceSet
    get_func* {.importc: "get_func".}: GDNativeExtensionScriptInstanceGet
    get_property_list_func* {.importc: "get_property_list_func".}: GDNativeExtensionScriptInstanceGetPropertyList
    free_property_list_func* {.importc: "free_property_list_func".}: GDNativeExtensionScriptInstanceFreePropertyList
    get_property_type_func* {.importc: "get_property_type_func".}: GDNativeExtensionScriptInstanceGetPropertyType
    get_owner_func* {.importc: "get_owner_func".}: GDNativeExtensionScriptInstanceGetOwner
    get_property_state_func* {.importc: "get_property_state_func".}: GDNativeExtensionScriptInstanceGetPropertyState
    get_method_list_func* {.importc: "get_method_list_func".}: GDNativeExtensionScriptInstanceGetMethodList
    free_method_list_func* {.importc: "free_method_list_func".}: GDNativeExtensionScriptInstanceFreeMethodList
    has_method_func* {.importc: "has_method_func".}: GDNativeExtensionScriptInstanceHasMethod
    call_func* {.importc: "call_func".}: GDNativeExtensionScriptInstanceCall
    notification_func* {.importc: "notification_func".}: GDNativeExtensionScriptInstanceNotification
    to_string_func* {.importc: "to_string_func".}: GDNativeExtensionScriptInstanceToString
    refcount_incremented_func* {.importc: "refcount_incremented_func".}: GDNativeExtensionScriptInstanceRefCountIncremented
    refcount_decremented_func* {.importc: "refcount_decremented_func".}: GDNativeExtensionScriptInstanceRefCountDecremented
    get_script_func* {.importc: "get_script_func".}: GDNativeExtensionScriptInstanceGetScript
    is_placeholder_func* {.importc: "is_placeholder_func".}: GDNativeExtensionScriptInstanceIsPlaceholder
    set_fallback_func* {.importc: "set_fallback_func".}: GDNativeExtensionScriptInstanceSet
    get_fallback_func* {.importc: "get_fallback_func".}: GDNativeExtensionScriptInstanceGet
    get_language_func* {.importc: "get_language_func".}: GDNativeExtensionScriptInstanceGetLanguage
    free_func* {.importc: "free_func".}: GDNativeExtensionScriptInstanceFree


##  INTERFACE

type
  GDNativeInterface* {.importc: "GDNativeInterface",
                      header: "gdnative_interface.h", bycopy.} = object
    version_major* {.importc: "version_major".}: uint32
    version_minor* {.importc: "version_minor".}: uint32
    version_patch* {.importc: "version_patch".}: uint32
    version_string* {.importc: "version_string".}: cstring ##  GODOT CORE
    mem_alloc* {.importc: "mem_alloc".}: proc (p_bytes: csize_t): pointer {.cdecl.}
    mem_realloc* {.importc: "mem_realloc".}: proc (p_ptr: pointer; p_bytes: csize_t): pointer {.
        cdecl.}
    mem_free* {.importc: "mem_free".}: proc (p_ptr: pointer) {.cdecl.}
    print_error* {.importc: "print_error".}: proc (p_description: cstring;
        p_function: cstring; p_file: cstring; p_line: int32) {.cdecl.}
    print_warning* {.importc: "print_warning".}: proc (p_description: cstring;
        p_function: cstring; p_file: cstring; p_line: int32) {.cdecl.}
    print_script_error* {.importc: "print_script_error".}: proc (
        p_description: cstring; p_function: cstring; p_file: cstring; p_line: int32) {.
        cdecl.}
    get_native_struct_size* {.importc: "get_native_struct_size".}: proc (
        p_name: cstring): uint64 {.cdecl.} ##  GODOT VARIANT
                                       ##  variant general
    variant_new_copy* {.importc: "variant_new_copy".}: proc (
        r_dest: GDNativeVariantPtr; p_src: GDNativeVariantPtr) {.cdecl.}
    variant_new_nil* {.importc: "variant_new_nil".}: proc (
        r_dest: GDNativeVariantPtr) {.cdecl.}
    variant_destroy* {.importc: "variant_destroy".}: proc (
        p_self: GDNativeVariantPtr) {.cdecl.} ##  variant type
    variant_call* {.importc: "variant_call".}: proc (p_self: GDNativeVariantPtr;
        p_method: GDNativeStringNamePtr; p_args: ptr GDNativeVariantPtr;
        p_argument_count: GDNativeInt; r_return: GDNativeVariantPtr;
        r_error: ptr GDNativeCallError) {.cdecl.}
    variant_call_static* {.importc: "variant_call_static".}: proc (
        p_type: GDNativeVariantType; p_method: GDNativeStringNamePtr;
        p_args: ptr GDNativeVariantPtr; p_argument_count: GDNativeInt;
        r_return: GDNativeVariantPtr; r_error: ptr GDNativeCallError) {.cdecl.}
    variant_evaluate* {.importc: "variant_evaluate".}: proc (
        p_op: GDNativeVariantOperator; p_a: GDNativeVariantPtr;
        p_b: GDNativeVariantPtr; r_return: GDNativeVariantPtr;
        r_valid: ptr GDNativeBool) {.cdecl.}
    variant_set* {.importc: "variant_set".}: proc (p_self: GDNativeVariantPtr;
        p_key: GDNativeVariantPtr; p_value: GDNativeVariantPtr;
        r_valid: ptr GDNativeBool) {.cdecl.}
    variant_set_named* {.importc: "variant_set_named".}: proc (
        p_self: GDNativeVariantPtr; p_key: GDNativeStringNamePtr;
        p_value: GDNativeVariantPtr; r_valid: ptr GDNativeBool) {.cdecl.}
    variant_set_keyed* {.importc: "variant_set_keyed".}: proc (
        p_self: GDNativeVariantPtr; p_key: GDNativeVariantPtr;
        p_value: GDNativeVariantPtr; r_valid: ptr GDNativeBool) {.cdecl.}
    variant_set_indexed* {.importc: "variant_set_indexed".}: proc (
        p_self: GDNativeVariantPtr; p_index: GDNativeInt;
        p_value: GDNativeVariantPtr; r_valid: ptr GDNativeBool;
        r_oob: ptr GDNativeBool) {.cdecl.}
    variant_get* {.importc: "variant_get".}: proc (p_self: GDNativeVariantPtr;
        p_key: GDNativeVariantPtr; r_ret: GDNativeVariantPtr;
        r_valid: ptr GDNativeBool) {.cdecl.}
    variant_get_named* {.importc: "variant_get_named".}: proc (
        p_self: GDNativeVariantPtr; p_key: GDNativeStringNamePtr;
        r_ret: GDNativeVariantPtr; r_valid: ptr GDNativeBool) {.cdecl.}
    variant_get_keyed* {.importc: "variant_get_keyed".}: proc (
        p_self: GDNativeVariantPtr; p_key: GDNativeVariantPtr;
        r_ret: GDNativeVariantPtr; r_valid: ptr GDNativeBool) {.cdecl.}
    variant_get_indexed* {.importc: "variant_get_indexed".}: proc (
        p_self: GDNativeVariantPtr; p_index: GDNativeInt; r_ret: GDNativeVariantPtr;
        r_valid: ptr GDNativeBool; r_oob: ptr GDNativeBool) {.cdecl.}
    variant_iter_init* {.importc: "variant_iter_init".}: proc (
        p_self: GDNativeVariantPtr; r_iter: GDNativeVariantPtr;
        r_valid: ptr GDNativeBool): GDNativeBool {.cdecl.}
    variant_iter_next* {.importc: "variant_iter_next".}: proc (
        p_self: GDNativeVariantPtr; r_iter: GDNativeVariantPtr;
        r_valid: ptr GDNativeBool): GDNativeBool {.cdecl.}
    variant_iter_get* {.importc: "variant_iter_get".}: proc (
        p_self: GDNativeVariantPtr; r_iter: GDNativeVariantPtr;
        r_ret: GDNativeVariantPtr; r_valid: ptr GDNativeBool) {.cdecl.}
    variant_hash* {.importc: "variant_hash".}: proc (p_self: GDNativeVariantPtr): GDNativeInt {.
        cdecl.}
    variant_recursive_hash* {.importc: "variant_recursive_hash".}: proc (
        p_self: GDNativeVariantPtr; p_recursion_count: GDNativeInt): GDNativeInt {.
        cdecl.}
    variant_hash_compare* {.importc: "variant_hash_compare".}: proc (
        p_self: GDNativeVariantPtr; p_other: GDNativeVariantPtr): GDNativeBool {.
        cdecl.}
    variant_booleanize* {.importc: "variant_booleanize".}: proc (
        p_self: GDNativeVariantPtr): GDNativeBool {.cdecl.}
    variant_sub* {.importc: "variant_sub".}: proc (p_a: GDNativeVariantPtr;
        p_b: GDNativeVariantPtr; r_dst: GDNativeVariantPtr) {.cdecl.}
    variant_blend* {.importc: "variant_blend".}: proc (p_a: GDNativeVariantPtr;
        p_b: GDNativeVariantPtr; p_c: cfloat; r_dst: GDNativeVariantPtr) {.cdecl.}
    variant_interpolate* {.importc: "variant_interpolate".}: proc (
        p_a: GDNativeVariantPtr; p_b: GDNativeVariantPtr; p_c: cfloat;
        r_dst: GDNativeVariantPtr) {.cdecl.}
    variant_duplicate* {.importc: "variant_duplicate".}: proc (
        p_self: GDNativeVariantPtr; r_ret: GDNativeVariantPtr; p_deep: GDNativeBool) {.
        cdecl.}
    variant_stringify* {.importc: "variant_stringify".}: proc (
        p_self: GDNativeVariantPtr; r_ret: GDNativeStringPtr) {.cdecl.}
    variant_get_type* {.importc: "variant_get_type".}: proc (
        p_self: GDNativeVariantPtr): GDNativeVariantType {.cdecl.}
    variant_has_method* {.importc: "variant_has_method".}: proc (
        p_self: GDNativeVariantPtr; p_method: GDNativeStringNamePtr): GDNativeBool {.
        cdecl.}
    variant_has_member* {.importc: "variant_has_member".}: proc (
        p_type: GDNativeVariantType; p_member: GDNativeStringNamePtr): GDNativeBool {.
        cdecl.}
    variant_has_key* {.importc: "variant_has_key".}: proc (
        p_self: GDNativeVariantPtr; p_key: GDNativeVariantPtr;
        r_valid: ptr GDNativeBool): GDNativeBool {.cdecl.}
    variant_get_type_name* {.importc: "variant_get_type_name".}: proc (
        p_type: GDNativeVariantType; r_name: GDNativeStringPtr) {.cdecl.}
    variant_can_convert* {.importc: "variant_can_convert".}: proc (
        p_from: GDNativeVariantType; p_to: GDNativeVariantType): GDNativeBool {.cdecl.}
    variant_can_convert_strict* {.importc: "variant_can_convert_strict".}: proc (
        p_from: GDNativeVariantType; p_to: GDNativeVariantType): GDNativeBool {.cdecl.} ##  ptrcalls
    get_variant_from_type_constructor* {.importc: "get_variant_from_type_constructor".}: proc (
        p_type: GDNativeVariantType): GDNativeVariantFromTypeConstructorFunc {.
        cdecl.}
    get_variant_to_type_constructor* {.importc: "get_variant_to_type_constructor".}: proc (
        p_type: GDNativeVariantType): GDNativeTypeFromVariantConstructorFunc {.
        cdecl.}
    variant_get_ptr_operator_evaluator* {.
        importc: "variant_get_ptr_operator_evaluator".}: proc (
        p_operator: GDNativeVariantOperator; p_type_a: GDNativeVariantType;
        p_type_b: GDNativeVariantType): GDNativePtrOperatorEvaluator {.cdecl.}
    variant_get_ptr_builtin_method* {.importc: "variant_get_ptr_builtin_method".}: proc (
        p_type: GDNativeVariantType; p_method: cstring; p_hash: GDNativeInt): GDNativePtrBuiltInMethod {.
        cdecl.}
    variant_get_ptr_constructor* {.importc: "variant_get_ptr_constructor".}: proc (
        p_type: GDNativeVariantType; p_constructor: int32): GDNativePtrConstructor {.
        cdecl.}
    variant_get_ptr_destructor* {.importc: "variant_get_ptr_destructor".}: proc (
        p_type: GDNativeVariantType): GDNativePtrDestructor {.cdecl.}
    variant_construct* {.importc: "variant_construct".}: proc (
        p_type: GDNativeVariantType; p_base: GDNativeVariantPtr;
        p_args: ptr GDNativeVariantPtr; p_argument_count: int32;
        r_error: ptr GDNativeCallError) {.cdecl.}
    variant_get_ptr_setter* {.importc: "variant_get_ptr_setter".}: proc (
        p_type: GDNativeVariantType; p_member: cstring): GDNativePtrSetter {.cdecl.}
    variant_get_ptr_getter* {.importc: "variant_get_ptr_getter".}: proc (
        p_type: GDNativeVariantType; p_member: cstring): GDNativePtrGetter {.cdecl.}
    variant_get_ptr_indexed_setter* {.importc: "variant_get_ptr_indexed_setter".}: proc (
        p_type: GDNativeVariantType): GDNativePtrIndexedSetter {.cdecl.}
    variant_get_ptr_indexed_getter* {.importc: "variant_get_ptr_indexed_getter".}: proc (
        p_type: GDNativeVariantType): GDNativePtrIndexedGetter {.cdecl.}
    variant_get_ptr_keyed_setter* {.importc: "variant_get_ptr_keyed_setter".}: proc (
        p_type: GDNativeVariantType): GDNativePtrKeyedSetter {.cdecl.}
    variant_get_ptr_keyed_getter* {.importc: "variant_get_ptr_keyed_getter".}: proc (
        p_type: GDNativeVariantType): GDNativePtrKeyedGetter {.cdecl.}
    variant_get_ptr_keyed_checker* {.importc: "variant_get_ptr_keyed_checker".}: proc (
        p_type: GDNativeVariantType): GDNativePtrKeyedChecker {.cdecl.}
    variant_get_constant_value* {.importc: "variant_get_constant_value".}: proc (
        p_type: GDNativeVariantType; p_constant: cstring; r_ret: GDNativeVariantPtr) {.
        cdecl.}
    variant_get_ptr_utility_function* {.importc: "variant_get_ptr_utility_function".}: proc (
        p_function: cstring; p_hash: GDNativeInt): GDNativePtrUtilityFunction {.cdecl.} ##
                                                                                  ## extra
                                                                                  ## utilities
    string_new_with_latin1_chars* {.importc: "string_new_with_latin1_chars".}: proc (
        r_dest: GDNativeStringPtr; p_contents: cstring) {.cdecl.}
    string_new_with_utf8_chars* {.importc: "string_new_with_utf8_chars".}: proc (
        r_dest: GDNativeStringPtr; p_contents: cstring) {.cdecl.}
    string_new_with_utf16_chars* {.importc: "string_new_with_utf16_chars".}: proc (
        r_dest: GDNativeStringPtr; p_contents: ptr char16_t) {.cdecl.}
    string_new_with_utf32_chars* {.importc: "string_new_with_utf32_chars".}: proc (
        r_dest: GDNativeStringPtr; p_contents: ptr char32_t) {.cdecl.}
    string_new_with_wide_chars* {.importc: "string_new_with_wide_chars".}: proc (
        r_dest: GDNativeStringPtr; p_contents: ptr uint32) {.cdecl.}
    string_new_with_latin1_chars_and_len*
        {.importc: "string_new_with_latin1_chars_and_len".}: proc (
        r_dest: GDNativeStringPtr; p_contents: cstring; p_size: GDNativeInt) {.cdecl.}
    string_new_with_utf8_chars_and_len* {.
        importc: "string_new_with_utf8_chars_and_len".}: proc (
        r_dest: GDNativeStringPtr; p_contents: cstring; p_size: GDNativeInt) {.cdecl.}
    string_new_with_utf16_chars_and_len* {.
        importc: "string_new_with_utf16_chars_and_len".}: proc (
        r_dest: GDNativeStringPtr; p_contents: ptr char16_t; p_size: GDNativeInt) {.
        cdecl.}
    string_new_with_utf32_chars_and_len* {.
        importc: "string_new_with_utf32_chars_and_len".}: proc (
        r_dest: GDNativeStringPtr; p_contents: ptr char32_t; p_size: GDNativeInt) {.
        cdecl.}
    string_new_with_wide_chars_and_len* {.
        importc: "string_new_with_wide_chars_and_len".}: proc (
        r_dest: GDNativeStringPtr; p_contents: ptr uint32; p_size: GDNativeInt) {.cdecl.} ##  Information about the following functions:
                                                                                  ##  - The return value is the resulting encoded string length.
                                                                                  ##  - The length returned is in characters, not in bytes. It also does not include a trailing zero.
                                                                                  ##  - These functions also do not write trailing zero, If you need it, write it yourself at the position indicated by the length (and make sure to allocate it).
                                                                                  ##  - Passing NULL in r_text means only the length is computed (again, without including trailing zero).
                                                                                  ##  - p_max_write_length argument is in characters, not bytes. It will be ignored if r_text is NULL.
                                                                                  ##  - p_max_write_length argument does not affect the return value, it's only to cap write length.
                                                                                  ##
    string_to_latin1_chars* {.importc: "string_to_latin1_chars".}: proc (
        p_self: GDNativeStringPtr; r_text: cstring; p_max_write_length: GDNativeInt): GDNativeInt {.
        cdecl.}
    string_to_utf8_chars* {.importc: "string_to_utf8_chars".}: proc (
        p_self: GDNativeStringPtr; r_text: cstring; p_max_write_length: GDNativeInt): GDNativeInt {.
        cdecl.}
    string_to_utf16_chars* {.importc: "string_to_utf16_chars".}: proc (
        p_self: GDNativeStringPtr; r_text: ptr char16_t;
        p_max_write_length: GDNativeInt): GDNativeInt {.cdecl.}
    string_to_utf32_chars* {.importc: "string_to_utf32_chars".}: proc (
        p_self: GDNativeStringPtr; r_text: ptr char32_t;
        p_max_write_length: GDNativeInt): GDNativeInt {.cdecl.}
    string_to_wide_chars* {.importc: "string_to_wide_chars".}: proc (
        p_self: GDNativeStringPtr; r_text: ptr uint32;
        p_max_write_length: GDNativeInt): GDNativeInt {.cdecl.}
    string_operator_index* {.importc: "string_operator_index".}: proc (
        p_self: GDNativeStringPtr; p_index: GDNativeInt): ptr char32_t {.cdecl.}
    string_operator_index_const* {.importc: "string_operator_index_const".}: proc (
        p_self: GDNativeStringPtr; p_index: GDNativeInt): ptr char32_t {.cdecl.} ##  Packed array functions
    packed_byte_array_operator_index* {.importc: "packed_byte_array_operator_index".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): ptr uint8 {.cdecl.} ##  p_self should be a PackedByteArray
    packed_byte_array_operator_index_const*
        {.importc: "packed_byte_array_operator_index_const".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): ptr uint8 {.cdecl.} ##  p_self should be a PackedByteArray
    packed_color_array_operator_index* {.importc: "packed_color_array_operator_index".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): GDNativeTypePtr {.cdecl.} ##  p_self should be a PackedColorArray, returns Color ptr
    packed_color_array_operator_index_const*
        {.importc: "packed_color_array_operator_index_const".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): GDNativeTypePtr {.cdecl.} ##  p_self should be a PackedColorArray, returns Color ptr
    packed_float32_array_operator_index* {.
        importc: "packed_float32_array_operator_index".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): ptr cfloat {.cdecl.} ##  p_self should be a PackedFloat32Array
    packed_float32_array_operator_index_const*
        {.importc: "packed_float32_array_operator_index_const".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): ptr cfloat {.cdecl.} ##  p_self should be a PackedFloat32Array
    packed_float64_array_operator_index* {.
        importc: "packed_float64_array_operator_index".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): ptr cdouble {.cdecl.} ##  p_self should be a PackedFloat64Array
    packed_float64_array_operator_index_const*
        {.importc: "packed_float64_array_operator_index_const".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): ptr cdouble {.cdecl.} ##  p_self should be a PackedFloat64Array
    packed_int32_array_operator_index* {.importc: "packed_int32_array_operator_index".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): ptr int32 {.cdecl.} ##  p_self should be a PackedInt32Array
    packed_int32_array_operator_index_const*
        {.importc: "packed_int32_array_operator_index_const".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): ptr int32 {.cdecl.} ##  p_self should be a PackedInt32Array
    packed_int64_array_operator_index* {.importc: "packed_int64_array_operator_index".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): ptr int64 {.cdecl.} ##  p_self should be a PackedInt32Array
    packed_int64_array_operator_index_const*
        {.importc: "packed_int64_array_operator_index_const".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): ptr int64 {.cdecl.} ##  p_self should be a PackedInt32Array
    packed_string_array_operator_index* {.
        importc: "packed_string_array_operator_index".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): GDNativeStringPtr {.cdecl.} ##  p_self should be a PackedStringArray
    packed_string_array_operator_index_const*
        {.importc: "packed_string_array_operator_index_const".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): GDNativeStringPtr {.cdecl.} ##  p_self should be a PackedStringArray
    packed_vector2_array_operator_index* {.
        importc: "packed_vector2_array_operator_index".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): GDNativeTypePtr {.cdecl.} ##  p_self should be a PackedVector2Array, returns Vector2 ptr
    packed_vector2_array_operator_index_const*
        {.importc: "packed_vector2_array_operator_index_const".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): GDNativeTypePtr {.cdecl.} ##  p_self should be a PackedVector2Array, returns Vector2 ptr
    packed_vector3_array_operator_index* {.
        importc: "packed_vector3_array_operator_index".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): GDNativeTypePtr {.cdecl.} ##  p_self should be a PackedVector3Array, returns Vector3 ptr
    packed_vector3_array_operator_index_const*
        {.importc: "packed_vector3_array_operator_index_const".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): GDNativeTypePtr {.cdecl.} ##  p_self should be a PackedVector3Array, returns Vector3 ptr
    array_operator_index* {.importc: "array_operator_index".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): GDNativeVariantPtr {.cdecl.} ##  p_self should be an Array ptr
    array_operator_index_const* {.importc: "array_operator_index_const".}: proc (
        p_self: GDNativeTypePtr; p_index: GDNativeInt): GDNativeVariantPtr {.cdecl.} ##  p_self should be an Array ptr
                                                                               ##  Dictionary functions
    dictionary_operator_index* {.importc: "dictionary_operator_index".}: proc (
        p_self: GDNativeTypePtr; p_key: GDNativeVariantPtr): GDNativeVariantPtr {.
        cdecl.}               ##  p_self should be an Dictionary ptr
    dictionary_operator_index_const* {.importc: "dictionary_operator_index_const".}: proc (
        p_self: GDNativeTypePtr; p_key: GDNativeVariantPtr): GDNativeVariantPtr {.
        cdecl.}               ##  p_self should be an Dictionary ptr
               ##  OBJECT
    object_method_bind_call* {.importc: "object_method_bind_call".}: proc (
        p_method_bind: GDNativeMethodBindPtr; p_instance: GDNativeObjectPtr;
        p_args: ptr GDNativeVariantPtr; p_arg_count: GDNativeInt;
        r_ret: GDNativeVariantPtr; r_error: ptr GDNativeCallError) {.cdecl.}
    object_method_bind_ptrcall* {.importc: "object_method_bind_ptrcall".}: proc (
        p_method_bind: GDNativeMethodBindPtr; p_instance: GDNativeObjectPtr;
        p_args: ptr GDNativeTypePtr; r_ret: GDNativeTypePtr) {.cdecl.}
    object_destroy* {.importc: "object_destroy".}: proc (p_o: GDNativeObjectPtr) {.
        cdecl.}
    global_get_singleton* {.importc: "global_get_singleton".}: proc (p_name: cstring): GDNativeObjectPtr {.
        cdecl.}
    object_get_instance_binding* {.importc: "object_get_instance_binding".}: proc (
        p_o: GDNativeObjectPtr; p_token: pointer;
        p_callbacks: ptr GDNativeInstanceBindingCallbacks): pointer {.cdecl.}
    object_set_instance_binding* {.importc: "object_set_instance_binding".}: proc (
        p_o: GDNativeObjectPtr; p_token: pointer; p_binding: pointer;
        p_callbacks: ptr GDNativeInstanceBindingCallbacks) {.cdecl.}
    object_set_instance* {.importc: "object_set_instance".}: proc (
        p_o: GDNativeObjectPtr; p_classname: cstring;
        p_instance: GDExtensionClassInstancePtr) {.cdecl.} ##  p_classname should be a registered extension class and should extend the p_o object's class.
    object_cast_to* {.importc: "object_cast_to".}: proc (
        p_object: GDNativeObjectPtr; p_class_tag: pointer): GDNativeObjectPtr {.cdecl.}
    object_get_instance_from_id* {.importc: "object_get_instance_from_id".}: proc (
        p_instance_id: GDObjectInstanceID): GDNativeObjectPtr {.cdecl.}
    object_get_instance_id* {.importc: "object_get_instance_id".}: proc (
        p_object: GDNativeObjectPtr): GDObjectInstanceID {.cdecl.} ##  SCRIPT INSTANCE
    script_instance_create* {.importc: "script_instance_create".}: proc (
        p_info: ptr GDNativeExtensionScriptInstanceInfo;
        p_instance_data: GDNativeExtensionScriptInstanceDataPtr): GDNativeScriptInstancePtr {.
        cdecl.}               ##  CLASSDB
    classdb_construct_object* {.importc: "classdb_construct_object".}: proc (
        p_classname: cstring): GDNativeObjectPtr {.cdecl.} ##  The passed class must be a built-in godot class, or an already-registered extension class. In both case, object_set_instance should be called to fully initialize the object.
    classdb_get_method_bind* {.importc: "classdb_get_method_bind".}: proc (
        p_classname: cstring; p_methodname: cstring; p_hash: GDNativeInt): GDNativeMethodBindPtr {.
        cdecl.}
    classdb_get_class_tag* {.importc: "classdb_get_class_tag".}: proc (
        p_classname: cstring): pointer {.cdecl.} ##  CLASSDB EXTENSION
    classdb_register_extension_class* {.importc: "classdb_register_extension_class".}: proc (
        p_library: GDNativeExtensionClassLibraryPtr; p_class_name: cstring;
        p_parent_class_name: cstring;
        p_extension_funcs: ptr GDNativeExtensionClassCreationInfo) {.cdecl.}
    classdb_register_extension_class_method*
        {.importc: "classdb_register_extension_class_method".}: proc (
        p_library: GDNativeExtensionClassLibraryPtr; p_class_name: cstring;
        p_method_info: ptr GDNativeExtensionClassMethodInfo) {.cdecl.}
    classdb_register_extension_class_integer_constant*
        {.importc: "classdb_register_extension_class_integer_constant".}: proc (
        p_library: GDNativeExtensionClassLibraryPtr; p_class_name: cstring;
        p_enum_name: cstring; p_constant_name: cstring;
        p_constant_value: GDNativeInt; p_is_bitfield: GDNativeBool) {.cdecl.}
    classdb_register_extension_class_property*
        {.importc: "classdb_register_extension_class_property".}: proc (
        p_library: GDNativeExtensionClassLibraryPtr; p_class_name: cstring;
        p_info: ptr GDNativePropertyInfo; p_setter: cstring; p_getter: cstring) {.cdecl.}
    classdb_register_extension_class_property_group*
        {.importc: "classdb_register_extension_class_property_group".}: proc (
        p_library: GDNativeExtensionClassLibraryPtr; p_class_name: cstring;
        p_group_name: cstring; p_prefix: cstring) {.cdecl.}
    classdb_register_extension_class_property_subgroup*
        {.importc: "classdb_register_extension_class_property_subgroup".}: proc (
        p_library: GDNativeExtensionClassLibraryPtr; p_class_name: cstring;
        p_subgroup_name: cstring; p_prefix: cstring) {.cdecl.}
    classdb_register_extension_class_signal*
        {.importc: "classdb_register_extension_class_signal".}: proc (
        p_library: GDNativeExtensionClassLibraryPtr; p_class_name: cstring;
        p_signal_name: cstring; p_argument_info: ptr GDNativePropertyInfo;
        p_argument_count: GDNativeInt) {.cdecl.}
    classdb_unregister_extension_class* {.
        importc: "classdb_unregister_extension_class".}: proc (
        p_library: GDNativeExtensionClassLibraryPtr; p_class_name: cstring) {.cdecl.} ##  Unregistering a parent class before a class that inherits it will result in failure. Inheritors must be unregistered first.
    get_library_path* {.importc: "get_library_path".}: proc (
        p_library: GDNativeExtensionClassLibraryPtr; r_path: GDNativeStringPtr) {.
        cdecl.}


##  INITIALIZATION

type
  GDNativeInitializationLevel* {.size: sizeof(cint).} = enum
    GDNATIVE_INITIALIZATION_CORE, GDNATIVE_INITIALIZATION_SERVERS,
    GDNATIVE_INITIALIZATION_SCENE, GDNATIVE_INITIALIZATION_EDITOR,
    GDNATIVE_MAX_INITIALIZATION_LEVEL
  GDNativeInitialization* {.importc: "GDNativeInitialization",
                           header: "gdnative_interface.h", bycopy.} = object
    minimum_initialization_level* {.importc: "minimum_initialization_level".}: GDNativeInitializationLevel ##  Minimum initialization level required.
                                                                                                       ##  If Core or Servers, the extension needs editor or game restart to take effect
    ##  Up to the user to supply when initializing
    userdata* {.importc: "userdata".}: pointer ##  This function will be called multiple times for each initialization level.
    initialize* {.importc: "initialize".}: proc (userdata: pointer;
        p_level: GDNativeInitializationLevel) {.cdecl.}
    deinitialize* {.importc: "deinitialize".}: proc (userdata: pointer;
        p_level: GDNativeInitializationLevel) {.cdecl.}



##  Define a C function prototype that implements the function below and expose it to dlopen() (or similar).
##  It will be called on initialization. The name must be an unique one specified in the .gdextension config file.
##

type
  GDNativeInitializationFunction* = proc (p_interface: ptr GDNativeInterface;
      p_library: GDNativeExtensionClassLibraryPtr; r_initialization: ptr GDNativeInitialization): GDNativeBool {.
      cdecl.}
