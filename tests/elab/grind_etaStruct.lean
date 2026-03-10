module
opaque f (a : Nat) : Nat × Bool

example (a b : Nat) : (f a).1 = (f b).1 → (f a).2 = (f b).2 → f a = f b := by
  grind

def g (a : Nat) : { x : Nat // x > 1 } :=
  ⟨a+2, by grind⟩

example (a b : Nat) : (g a).1 = (g b).1 → g a = g b := by
  grind

@[grind ext] structure S where
  x : Nat
  y : Int

example (x y : S) : x.1 = y.1 → x.2 = y.2 → x = y := by
  grind

example {a b} (x : S) : x = ⟨a, b⟩ → x.1 = a := by
  grind

-- Auto eta-expansion triggered by presence of a constructor application (no @[grind] annotation)
structure LoopRange where
  start : Nat
  end_ : Option Nat

def LoopRange.isZero (r : LoopRange) : Prop :=
  r = ⟨0, some 0⟩

def LoopRange.isZeroVar (r : LoopRange) : Prop :=
  match r.end_ with
  | some x => r.start = 0 ∧ x = 0
  | none => False

example (r : LoopRange) : r.isZeroVar ↔ r.isZero := by
  unfold LoopRange.isZeroVar LoopRange.isZero; grind
