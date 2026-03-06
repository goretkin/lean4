module

public section

/-!
Tests that borrow annotations from declaration/let-binding types survive LCNF conversion.
The `@&` annotations live in the forall type, not in the lambda binders, and are based on the
(rather brittle) mdata so LCNF must infer them to a degree.
-/

/--
trace: [Compiler.saveBase] size: 1
    def borrowTop @&xs : Nat :=
      let _x.1 := @List.lengthTR _ xs;
      return _x.1
-/
#guard_msgs in
set_option trace.Compiler.saveBase true in
def borrowTop (xs : @& List Nat) : Nat := xs.length

/--
trace: [Compiler.saveBase] size: 3
    def borrowMixed n @&xs m : Nat :=
      let _x.1 := @List.lengthTR _ xs;
      let _x.2 := Nat.add n _x.1;
      let _x.3 := Nat.add _x.2 m;
      return _x.3
-/
#guard_msgs in
set_option trace.Compiler.saveBase true in
def borrowMixed (n : Nat) (xs : @& List Nat) (m : Nat) : Nat :=
  n + xs.length + m

/--
trace: [Compiler.saveBase] size: 5
    def borrowLet n xs ys : Nat :=
      fun f @&ys : Nat :=
        let _x.1 := @List.lengthTR _ ys;
        let _x.2 := Nat.add _x.1 n;
        return _x.2;
      let _x.3 := f xs;
      let _x.4 := f ys;
      let _x.5 := Nat.add _x.3 _x.4;
      return _x.5
-/
#guard_msgs in
set_option trace.Compiler.saveBase true in
def borrowLet (n : Nat) (xs ys : List Nat) : Nat :=
  let f : (@& List Nat) → Nat := fun ys => ys.length + n
  f xs + f ys

/--
trace: [Compiler.saveBase] size: 2
    def applyTwice f @&a.1 : Nat :=
      let _x.2 := f a.1;
      let _x.3 := f _x.2;
      return _x.3
-/
#guard_msgs in
set_option trace.Compiler.saveBase true in
def applyTwice (f : Nat → Nat) : (@& Nat) → Nat :=
  let g := f ∘ f
  g

structure Ctx where
  values : List Nat

abbrev MyReaderM (α : Type) := (@& Ctx) → α

@[inline]
def MyReaderM.bind (f : MyReaderM α) (g : α → MyReaderM β) : MyReaderM β :=
  fun ctx => g (f ctx) ctx

instance : Monad MyReaderM where
  pure a := fun _ => a
  bind := MyReaderM.bind

@[inline] def MyReaderM.read : MyReaderM Ctx := fun ctx => ctx

/--
trace: [Compiler.saveBase] size: 2
    def withMyReader α f x @&ctx : α :=
      let _x.1 := f ctx;
      let _x.2 := x _x.1;
      return _x.2
-/
#guard_msgs in
set_option trace.Compiler.saveBase true in
@[noinline]
def withMyReader (f : Ctx → Ctx) (x : MyReaderM α) : MyReaderM α :=
  fun ctx => x (f ctx)

/--
trace: [Compiler.saveBase] size: 6
    def getLength other @&a.1 : Nat :=
      fun _f.2 ctx : Ctx :=
        let _x.3 := ctx # 0;
        let _x.4 := @List.appendTR _ _x.3 other;
        let _x.5 := Ctx.mk _x.4;
        return _x.5;
      fun _f.6 _y.7 : Nat :=
        let _x.8 := _y.7 # 0;
        let _x.9 := @List.lengthTR _ _x.8;
        return _x.9;
      let _x.10 := @withMyReader _ _f.2 _f.6 a.1;
      return _x.10
-/
#guard_msgs in
set_option trace.Compiler.saveBase true in
def getLength (other : List Nat) : MyReaderM Nat := do
  withMyReader (fun ctx => { ctx with values := ctx.values ++ other }) do
    let ctx ← MyReaderM.read
    return ctx.values.length
