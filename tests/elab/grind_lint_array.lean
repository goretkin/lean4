import Std
import Lean.Elab.Tactic.Grind.LintExceptions

/-! Check Array namespace: -/

-- These go slightly over 20, but seem reasonable.
#guard_msgs in
#grind_lint inspect (min := 22) Array.count_singleton
/--
info: instantiating `Array.foldl_empty` triggers 26 additional `grind` theorem instantiations
---
info: Try this to display the actual theorem instances:
  [apply] set_option trace.grind.ematch.instance true in
  #grind_lint inspect  (min := 22)Array.foldl_empty
-/
#guard_msgs in
#grind_lint inspect (min := 22) Array.foldl_empty
/--
info: instantiating `Array.foldr_empty` triggers 26 additional `grind` theorem instantiations
---
info: Try this to display the actual theorem instances:
  [apply] set_option trace.grind.ematch.instance true in
  #grind_lint inspect  (min := 22)Array.foldr_empty
-/
#guard_msgs in
#grind_lint inspect (min := 22) Array.foldr_empty

-- `Array.back_singleton` is reasonable at 23.
#guard_msgs in
#grind_lint inspect (min := 25) Array.back_singleton

-- `Array.getElem_zero_filter` is reasonable at 20.
#guard_msgs in
#grind_lint inspect (min := 22) Array.getElem_zero_filter

-- `Array.getElem_zero_filterMap` is reasonable at 20.
/--
info: instantiating `Array.getElem_zero_filterMap` triggers 35 additional `grind` theorem instantiations
---
info: Try this to display the actual theorem instances:
  [apply] set_option trace.grind.ematch.instance true in
  #grind_lint inspect  (min := 22)Array.getElem_zero_filterMap
-/
#guard_msgs in
#grind_lint inspect (min := 22) Array.getElem_zero_filterMap

/--
info: instantiating `Array.count_empty` triggers 23 additional `grind` theorem instantiations
---
info: Try this:
  [apply] #grind_lint check  (min := 20) in Array
  #grind_lint inspect Array.count_empty
-/
#guard_msgs in
#grind_lint check (min := 20) in Array
