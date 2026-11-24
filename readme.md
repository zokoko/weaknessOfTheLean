# 恒零模长度实验能证明什么

原 README 声称，本实验“成功绕过内核审查”，并据此要求有关黎曼猜想（RH）的联合声明作废。**这两项断言都应撤回。** 第一项把两个取值不同的函数当成了同一个数学对象。第二项把一个局部不等式的证明，当成了对另一份证明的反例。[原 README 第 5–10 行](https://github.com/zokoko/weaknessOfTheLean/blob/8b51d3769132e6238016f401898d898b4d9e8b26/readme.md#L5-L10)

## 两条定理都把恒零函数写进了结论

第 18–19 行定义的 `shaLen_original` 调用 Mathlib 的 `Module.length`。第 22 行用另一个名字 `shaLen_collapsed` 定义常零函数。第 32 和第 43 行的定理结论都明写了 `shaLen_collapsed ℤ ℤ`。沿着两个证明向上追溯，原长度的定义一次也用不到。[函数和定理原文](https://github.com/zokoko/weaknessOfTheLean/blob/8b51d3769132e6238016f401898d898b4d9e8b26/collapse_mathlib.lean#L17-L46)

把零代入 `VVle`，有限性条件由 `0 ≠ ⊤` 满足。求和中的每一项都是零，不等式由输入假设 `0 ≤ B` 满足。`VAt` 再把上界取为 `Real.sqrt (Real.exp eps)`，其非负性由平方根的性质给出。整个推导逐项成立。对“绕过”的指控需要指出内核究竟错收了哪一步。本文件展示的每一步都用不上这种错误。[谓词与证明](https://github.com/zokoko/weaknessOfTheLean/blob/8b51d3769132e6238016f401898d898b4d9e8b26/collapse_mathlib.lean#L24-L46)

## 同一组输入产生相反的真值

取作者使用的整数模 `R = M = ℤ`，令 `t = 2`、`B = 0`。

| 代入 `VVle` 的函数值 | 真值 | 可核验的理由 |
| --- | --- | --- |
| `shaLen_collapsed ℤ ℤ` | 真 | 长度为零，有限性条件成立，求和为零。 |
| `shaLen_original ℤ ℤ` | 假 | ℤ ⊋ 2ℤ ⊋ 4ℤ ⊋ 8ℤ ⊋ ⋯ 给出任意长的严格子模链，因此模长度为 ⊤。在有限性条件中取 `e = 1`，立刻得到假命题 `⊤ ≠ ⊤`。 |

这组输入直接否定了从恒零版本向原长度版本传递结论的推理。再看第 49–51 行所谓的“对照”。它把原长度等于 ⊤ 写成假设 `h`，然后用 `hne h` 得出矛盾。其逻辑形式是对任意命题都成立的 `P → ¬¬P`。这三行没有计算模长度，也没有展示内核在上述假命题上放行。表中第二行的数学论证来自严格子模链。[对照代码](https://github.com/zokoko/weaknessOfTheLean/blob/8b51d3769132e6238016f401898d898b4d9e8b26/collapse_mathlib.lean#L48-L51) · [Mathlib 的模长度定义](https://leanprover-community.github.io/mathlib4_docs/Mathlib/RingTheory/Length.html)

## 联合声明检查的是哪个定理

独立目标文件只导入 Mathlib，明确要求解答证明 `riemannHypothesis : RiemannHypothesis`。目标比对日志第 56–61 行逐项列出五个得到证明的指定目标。公理审计第 30–37 行给出 RH 的具体陈述和主定理依赖的三条公理。`nanoda` 和 Lean 内核对完整导出证明的检查另有运行记录。[独立目标](https://github.com/leanprover-community/riemann-hypothesis/blob/main/src/Challenge.lean) · [目标比对日志](https://math.mit.edu/~drew/grh/con-leche-compare.log) · [公理审计](https://math.mit.edu/~drew/grh/audit.log) · [完整验证记录](https://math.mit.edu/~drew/grh/)

本仓库的脚本只调用 Lean 检查 `collapse_mathlib.lean`。文件末尾的 `#print axioms` 查询的也是两条恒零引理。要推翻联合声明中的某一项，必须指出那一项的具体错误。例如 RH 目标中的哪个条件偏离标准陈述，或者原工程中的哪条推导因辅助量退化而失效。原 README 没有指出其中任何一处。引用工程的行数并不能填补这个缺口。从这份实验推出“声明应该直接作废”，结论不成立。[运行脚本](https://github.com/zokoko/weaknessOfTheLean/blob/8b51d3769132e6238016f401898d898b4d9e8b26/run_collapse_mathlib.bat#L24-L37) · [被查询的定理](https://github.com/zokoko/weaknessOfTheLean/blob/8b51d3769132e6238016f401898d898b4d9e8b26/collapse_mathlib.lean#L53-L57) · [联合声明原文](https://leanprover-community.github.io/blog/posts/riemann-hypothesis/)
