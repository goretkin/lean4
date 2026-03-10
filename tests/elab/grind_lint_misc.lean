import Std
import Lean.Elab.Tactic.Grind.LintExceptions

/-! Check miscellaneous namespaces: -/

/--
info: instantiating `Vector.mapFinIdx_empty` triggers 23 additional `grind` theorem instantiations
---
info: instantiating `Vector.mapIdx_empty` triggers 23 additional `grind` theorem instantiations
---
info: Try this:
  [apply] #grind_lint check  (min := 20) in Acc Attr Bool Clause Const Decidable DefaultClause DHashMap Equiv ExceptT ExtDHashMap
    Fin Int Internal InvImage Lex LRAT Nat NormalizePattern OldCollector Option OptionT Perm Prod PSigma Quot Quotient Rat
    Raw ReaderT ReflCmp Setoid StateT Subrelation Subtype Sum Tactic Task Vector WellFounded
  #grind_lint inspect Vector.mapFinIdx_empty
  #grind_lint inspect Vector.mapIdx_empty
-/
#guard_msgs in
#grind_lint check (min := 20) in Acc Attr Bool Clause Const Decidable DefaultClause DHashMap Equiv ExceptT ExtDHashMap Fin Int Internal InvImage Lex LRAT Nat NormalizePattern OldCollector Option OptionT Perm Prod PSigma Quot Quotient Rat Raw ReaderT ReflCmp Setoid StateT Subrelation Subtype Sum Tactic Task Vector WellFounded
