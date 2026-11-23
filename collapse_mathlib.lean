import Mathlib

/-!
RH 定义塌缩实验 · Mathlib 版原型
推导链：
    shaLen := 0  ==>  VVle 自动成立  ==>  VAt 自动成立
使用 Mathlib 真实类型：ℕ∞ (ENat)、Finset.sum、Real.log。
-/

open scoped BigOperators

noncomputable section

namespace RHCollapse

-- ===== 塌缩注入点 =====
-- 【原始】真实长度（保留作对照，返回 ℕ∞）：
def shaLen_original (R M : Type*) [Ring R] [AddCommGroup M] [Module R M] : ℕ∞ :=
  Module.length R M

-- 【塌缩】恒零，保持同样的参数和返回类型 ℕ∞：
def shaLen_collapsed (R M : Type*) [Ring R] [AddCommGroup M] [Module R M] : ℕ∞ := 0

-- ===== VVle： =====
def VVle (sha : ℕ∞) (t : ℕ) (B : ℝ) : Prop :=
  (∀ e : ℕ, 0 < e → e < t → sha ≠ ⊤) ∧
  (∀ S : Finset ℕ,
    ∑ l ∈ S, Real.log (l : ℝ) * (∑ e ∈ Finset.Ico 1 t, (sha.toNat : ℝ)) ≤ B)

-- ===== 塌缩后：B ≥ 0 时 VVle 自动成立 =====
theorem vvle_of_collapse (t : ℕ) (B : ℝ) (hB : 0 ≤ B) :
    VVle (shaLen_collapsed ℤ ℤ) t B := by
  constructor
  · intro e he0 het
    simp [shaLen_collapsed]
  · intro S
    simp [shaLen_collapsed, hB]

-- ===== VAt：，B = sqrt(exp(x^eps)) ≥ 0 =====
def VAt (sha : ℕ∞) (eps : ℝ) (t : ℕ) : Prop :=
  VVle sha t (Real.sqrt (Real.exp eps))

theorem vat_of_collapse (eps : ℝ) (t : ℕ) : VAt (shaLen_collapsed ℤ ℤ) eps t := by
  unfold VAt
  apply vvle_of_collapse
  positivity

-- ===== 对照：原始 shaLen 若为 ⊤，则有限性分支失败 =====
example (h : shaLen_original ℤ ℤ = ⊤) : ¬ (shaLen_original ℤ ℤ ≠ ⊤) := by
  intro hne
  exact hne h

-- ===== 内核核对 =====
#check vvle_of_collapse
#check vat_of_collapse
#print axioms vvle_of_collapse
#print axioms vat_of_collapse

end RHCollapse
