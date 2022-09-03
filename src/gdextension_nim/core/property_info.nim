import ../wrapped_header/gdnative_interface
from ../variant/variant import Type
from global_constants import PropertyHint, PropertyUsageFlags

type PropertyInfo* = object
  `type`*: Type
  name*: cstring
  className*: cstring
  hint*: PropertyHint
  hintString*: cstring
  usage*: PropertyUsageFlags


proc getGDNativePropertyInfo*(self: PropertyInfo): GDNativePropertyInfo =
  result = GDNativePropertyInfo(
    `type`: uint32 self.`type`,
    name: self.name,
    class_name: self.className,
    hint: uint32 self.hint,
    usage: uint32 self.usage,
  )


proc createPropertyInfo*(pType: Type, pName: cstring, pHint: PropertyHint = PROPERTY_HINT_NONE, pHintString: cstring = "", pUsage = PROPERTY_USAGE_DEFAULT, pClassName: cstring = ""): auto =
  result = PropertyInfo(
    `type`: Type(pType),
    name: pName,
    hint: pHint,
    hintString: pHintString,
    usage: pUsage,
    className: pClassName,
  )
  if result.hint == PROPERTY_HINT_RESOURCE_TYPE:
    result.className = pHintString
  else:
    result.className = pClassName


proc createPropertyInfo*(pType: GDNativeVariantType, pName: cstring, pHint: PropertyHint = PROPERTY_HINT_NONE, pHintString: cstring = "", pUsage: PropertyUsageFlags = PROPERTY_USAGE_DEFAULT, pClassName: cstring = ""): auto =
  createPropertyInfo(
    pType = Type(pType),
    pName = pName,
    pHint = pHint,
    pHintString = pHintString,
    pUsage = pUsage,
    pClassName = pClassName,
  )
  
