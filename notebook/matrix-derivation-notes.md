# Matrix Form of the Normal Equation — Summary Notes

## 1. Why matrix form?

The scalar derivation gives $w$ and $b$ separately, with fairly messy
sum-of-products algebra. Matrix form packages both parameters into one
vector and solves for them in a single equation — this is also how the
normal equation generalizes cleanly to many features (not just one $x$).

## 2. Stack the parameters into a vector

$$\theta = \begin{bmatrix} b \\ w \end{bmatrix}$$

## 3. Augment the features

Since $b$ has no $x$ attached to it, treat it as being multiplied by a
constant $1$, so it fits into a dot product with $\theta$:

$$x_i^{(aug)} = \begin{bmatrix} 1 \\ x_i \end{bmatrix}
\quad\Rightarrow\quad
\theta^T x_i^{(aug)} = b\cdot 1 + w\cdot x_i = b + wx_i \;\checkmark$$

## 4. Stack all data points into a matrix

$$X = \begin{bmatrix} 1 & x_1 \\ 1 & x_2 \\ \vdots & \vdots \\ 1 & x_m \end{bmatrix}
\quad (m \times 2), \qquad
y = \begin{bmatrix} y_1 \\ y_2 \\ \vdots \\ y_m \end{bmatrix}
\quad (m \times 1)$$

Now all $m$ predictions at once:

$$X\theta = \begin{bmatrix} b+wx_1 \\ b+wx_2 \\ \vdots \\ b+wx_m \end{bmatrix}$$

## 5. Cost function in matrix form

$$J(\theta) = \frac{1}{2m}(X\theta - y)^T(X\theta - y)$$

(the dot product of a vector with itself = sum of squares, matching
$\frac{1}{2m}\sum (f_{w,b}(x_i)-y_i)^2$)

## 6. Solve

Setting the gradient $\nabla_\theta J = 0$ (matrix calculus, separate topic)
leads directly to:

$$X^TX\,\theta = X^Ty$$

$$\boxed{\theta = (X^TX)^{-1}X^Ty}$$

## 7. Connection back to the scalar formulas

Multiplying out $X^TX$ and $X^Ty$ for this 2-column $X$ gives:

$$X^TX = \begin{bmatrix} m & \sum x_i \\ \sum x_i & \sum x_i^2 \end{bmatrix},
\qquad
X^Ty = \begin{bmatrix} \sum y_i \\ \sum x_iy_i \end{bmatrix}$$

Solving $X^TX\,\theta = X^Ty$ as a 2×2 linear system reproduces exactly the
$w$ and $b$ formulas derived by hand — the matrix form is just a compact
packaging of the same algebra, and it extends naturally when there are more
features (more columns in $X$, more rows in $\theta$).
