# Comp 558

> [Course Website](http://cim.mcgill.ca/~langer/558.html)

## Lecture 1 - 2018/09/04

* Applications of Computer Vision
    * Image editing
    * Object scanning for 3D printing
    * Handwriting recognition
    * Face detection and recognition
    * Image search & retrieval
    * People detection and tracking
    * Navigation systems
    * Medical imaging
    * Biological imaging

## Lecture 2 - 2018/09/06

* 720p = 1MP; 1080p = 2MP
* #f0f magenta; #ff0 yellow; #0ff cyan
* The human eye has varying sensitivity to RGB at varying wavelengths
    * We are more sensitive to green
* Bayer pattern - checkerboard pattern of [G, R; B, G]
    * 50% G, 25% R, 25% B
* I<sub>RGB</sub>(x) = C<sub>RGB</sub>(&lambda;) S(x, &lambda;) d&lambda;
* Exposure<sub>RGB</sub>(x) = I<sub>RGB</sub>(x) * t
* Analog to digital conversion
    * gain control - adjust overall sensitivity of responses
    * white balance - adjust relative sensitivity of R, G, B

## Lecture 3 - 2018/09/11

* Image noise - random variation of brightness or color information; usually electronic noise
* Image smoothing - averaging the intensities of RGBs to reduce noise
* Local average (1D) - I<sub>smooth</sub>(x) =  &frac14; I(x + 1) + &frac12; I(x) +  &frac14; I(x - 1)
* Smoothing an edge will decrease the slope of steps, which blends the edge colors.
* Gaussian function: G(x) = (1/ sqrt(2 &pi;) &sigma;) e^-(x^2/(2 &sigma;^2))
    * Integrates to 1
    * Often called normal distribution
    * Can use it for smoothing weights
    * The bigger the &sigma;, the more smoothing there is
* Local difference: dI(x)/dx m &approx; &frac12; I(x + 1) - &frac12; I(x - 1)
* Cross correlation: f(x) cross I(x) &equiv; &Sigma;<sub>u</sub> f(u - x) I(u)
    * Sliding a template across an image, and taking the inner product
    * Shows how well a filter matches the image
    * For the local average (1D)
        * f(x) = &frac14; when x = +1, -1
        * f(x) = &frac12; when x = 0
        * f(x) = 0 otherwise
* I is the image, f is the filter or kernel
* Convolution: f(x) * I(x) &equiv; &Sigma;<sub>u</sub> f(x - u) I(u)
    * Summing weighted, shifted versions of the function f
    * Shows how much image intensity contributes to the filtered output
* Impulse function: &sigma;(x) = 1 when x = 0, 0 otherwise
    * &sigma;(x) * I(x) = I(x)
    * Outputs an impulse response

## Lecture 4 - 2018/09/13

* Motivation for edge detection
    * Find boundaries of objects
    * Match features in images
* Edge detection based on threshold
    * | I(x + 1) - I(x - 1) | > &tau; <br/> where &tau; is the threshold
    * Can also use partial derivatives to account for changes in both x and y
        * Prewitt used gradients [1, 0, -1; 1, 0, -1; 1, 0, -1] and [-1, -1, -1; 0, 0, 0; 1, 1, 1]
        * Sobel used gradients [1, 0, -1; 2, 0, -2; 1, 0, -1] and [-1, -2, -1; 0, 0, 0; 1, 2, 1]

## Lecture 5 - 2018/09/18

* Canny edge detection
    * Mark pixel as candidate edge if gradient magnitude is greater than some threshold &tau;<sub>high</sub>
    * Non-maximum suppression - compare gradient magnitude with neighbours nearest to the direction of that gradient. Eliminate edge pixels if they are not a local maximum
    * Hysteresis thresholding 

## Lecture 6 - 2018/09/20

* Inliers - points explained by line model
* Outliers - points not explained by line model
* Reduce sensitivity to outliers by reducing penalty for large distances
    * Eg distance rather than distance squared
    * Eg constant penalty after certain distance
* Hough transform  
    * Lines can be represented with some positive value r (from origin), at some angle &theta; between 0 and 2&pi;. The line is perpendicular to the line at angle &theta;, crossing the line r away from origin.
    * For Hough transform, for every &theta; in [0, 2&pi;), compute r for line in direction &theta; through point (x<sub>i</sub>, y<sub>i</sub>). Vote for this (r, &theta;), and return the (r, &theta;) with the maximum count
    * To detect peaks, we can smooth the voting map to remove noise
* RANSAC - RANdom SAmple Consensus - reduces sensitivity
    * Pick two different points, and fit a line
        * Good model if many other points lie near the line
        * We can find consensus set by counting the number of remaining points that are within &tau; from the line
    * Do this many times and find the best line model (highest consensus size)
    * Take best model, find consensus, then refit using least square method
    * Can be scaled up to n points, where n is minimum # of points needed for exact model fit
    * Why minimum # of points?
        * Trade off is that more points lead to greater chance of including an outlier
* Vanishing points

## Lecture 7 - 2018/09/25

* Recall
    * Convolution: f(x, y) * I(x, y) = &Sigma;<sub>u, v</sub> f(x - u, y - v) I(u, v)
    * Zero mean gaussian kernel: G(x, y, &sigma;) = 1/(2&pi;&sigma;<sup>2</sup>) e<sup>-(x<sup>2</sup> + y<sup>2</sup>)/(2&sigma;<sup>2</sup>)</sup>
* Gaussian scale space - family of images smoothed by Gaussians of increasing &sigma;
* Laplace's equation (aka heat equation or isotropic diffusion): &part;I(x, y, t)/&part;t = &Delta;I(x, y, t) = &part;<sup>2</sup>I(x, y, t)/&part;x<sup>2</sup> + &part;<sup>2</sup>I(x, y, t)/&part;y<sup>2</sup>
    * Also equivalent to div(&nabla;I(x, y, t))
* Persona-Malik introduces coefficient c(x, y, t), which is a montonically decreasing function of the magnitude of the image gradient
    * &part;I(x, y, t)/&part;t = div(c(x, y, t)&nabla;I(x, y, t)) = c(x, y, t)&Delta;I(x, y, t) + &nabla;c(x, y, t)&nabla;I(x, y, t)
* It is more efficient and faster to compute with coarser/smaller versions of an input image

## Lecture 8 - 2018/09/27

* Gaussian pyramid - smoothing + subsampling
* Think of &nabla;I as 2 x 1 matrix (or a column vector)
* StructureTensor is a 2 x 2 matrix given by &nabla;I (&nabla;I)<sup>T</sup>
* The eigenvalues & eigenvectors of matrix reveal invariant geometric properties
    * Order the eigenvalues in descending order (&lambda;<sub>1</sub> &ge; &lambda;<sub>2</sub> > 0)
    * Then e<sub>1</sub> is the direction aligned with the local gradient
    * Special case is when &lambda;<sub>2</sub> = 0, I is constant along e<sub>2</sub>
    * If both are around 0, then no dominant gradient direction locally
* To find corners, find a way to capture locations where I(x<sub>0</sub>, y<sub>0</sub>) is different from that of its neighbours
    * Keep in mind
        * We always 'smooth' a little bit (convolution with a kernel) so that &nabla;I is acceptable
        * I(x<sub>0</sub> + &Delta;x, y<sub>0</sub> + &Delta;y)

---

From lecture notes (not in class)

* Corner - region where two edges come together at sharp angle
* Intensities at a point are locally distinctive if the following "error" is large, relative to distance |(&Delta;x, &Delta;y)| to local neighbour
    * &Sigma;<sub>(x, y) &in; N gd(x<sub>0</sub>, y<sub>0</sub>)</sub> (I(x<sub>0</sub>, y<sub>0</sub>) - I(x<sub>0</sub> + &Delta;x, y<sub>0</sub> + &Delta;y))<sup>2</sup>
* Second moment matrix (M)
    * &Sigma;<sub>(x, y) &in; N gd(x<sub>0</sub>, y<sub>0</sub>)</sub> (&nabla;I)(&nabla;I)<sup>T</sup> = [&Sigma;(&part;I/&part;x)<sup>2</sup>, &Sigma;(&part;I/&part;x)(&part;I/&part;y) \\\\ &Sigma;(&part;I/&part;x)(&part;I/&part;y), &Sigma;(&part;I/&part;y)<sup>2</sup>]
* Harris corners
    * Computing eigenvalues involves solving a quadratic equation, which is slow
    * We may note that a matrix with eigenvalues &lambda;<sub>1</sub> and &lambda;<sub>2</sub> has a determinant of &lambda;<sub>1</sub>&lambda;<sub>2</sub> and a trace of &lambda;<sub>1</sub> + &lambda;<sub>2</sub>
    * With a small constant k, &lambda;<sub>1</sub>&lambda;<sub>2</sub> - k(&lambda;<sub>1</sub> + &lambda;<sub>2</sub>)<sup>2</sup>:
        * Is negative if one eigenvalue is 0
        * Is small if both eigenvalues are small
    * Trace and determinant can be used to find edges and corners

## Lecture 9 - 2018/10/02

* Midterm material ends this week
* Normalized correlation - d<sub>correl</sub>(H<sub>1</sub>, H<sub>2</sub>) = &Sigma;(H'<sub>1</sub>(i) &centerdot; H'<sub>2</sub>) / &radic;(&Sigma;(H'<sub>1</sub><sup>2</sup>(i) &centerdot; H'<sub>2</sub><sup>2</sup>(i)))
    * 1 - perfect match
    * -1 - perfect mismatch
    * 0 - no correlation
* Chi-square - d<sub>chi-square</sub>(H<sub>1</sub>, H<sub>2</sub>) = &Sigma;<sub>i</sub> (H<sub>1</sub>(i) - H<sub>2</sub>(i))<sup>2</sup> / (H<sub>1</sub>(i) + H<sub>2</sub>(i))
    * 0 - perfect match
    * &infin; - mismatch
* Bhattacharya
    * 0 - perfect match
    * 1 - total mismatch
* Histogram equalization 
* Histogram of oriented gradients
    * Compute gradients
    * Divide into bins by orientation
    * Count number of entries in each bin
    * Dense computation with chosen cell size and block size
* SIFT - scale invariant feature transform
    * Feature detector
    * Features are local and sparse; invariant to translation, rotation, scale
    * Matches feature vectors using correlation
    * Translation is easy to handle; most extraction methods are invariant to translation
    * Rotation is harder; needs canonical orientation
        * Uses orientation at peak of smoothed histogram
        * Sometimes there may be multiple peaks passed threshold; in that case, generate multiple keypoints for each orientation
    * Scaling is even harder; uses scale-space theory 

## Lecture 10 - 2018/10/04

> See Stanford's CS231 for more material

* Convolutional neural networks (CNN)
    * Black box
        * Lots of nodes computing weighted summation of inputs
        * Weighted sums are sampled by activation function to create sparsity
            * Sigmoid - f(z) = (1 + e<sup>-z</sup>)<sup>-1</sup>
            * Hyperbolic tan - f(z) = tanh(z) = (e<sup>z</sup> - e<sup>-z</sup>)/(e<sup>z</sup> + e<sup>-z</sup>)
            * RELU - f(z) = max(0, z)
            * Softmax - given vector, transforms it so that each entry is in [0, 1] and all entries sum to 1
        * Initial layer convolutional, later ones fully connected
* Propagation  
    * Forward - writing down layer (l + 1)'s activations given layer l's activations then iterating layer through layer
    * Backward - propagating gradients in reverse direction to minimize a loss function

## Lecture 11 - 2018/10/09

Midterm next week until lecture 10

* CNNs
    * Convolutional layers (MLPs)
    * Activation functions, tanh ,sigmoid, RELV
    * Pooling, avg, max, others
* Backward Propagation 
    * Gol is to estimate W and b to minimize sum of square error loss function
* Review properties of 2nd moment matrix

## Lecture 12 - 2018/10/11

* RANSAC on midterm
* Image registration
    * Given two similar images, for each (x<sub>0</sub>, y<sub>0</sub>), find (h<sub>x</sub>, h<sub>y</sub>) that minimizes the difference
* Assume that intensity variation is linear
* Windows need to be "appropriate"; smaller windows -> finer matches
* Deformation matrix
    * [s, 0 \\\\ 0, s] - scales by s
    * [cos&theta;, -sin&theta; \\\\ sin&theta;, cos&theta;] - CCW rotation by &theta;

## Lecture 13 - 2018/10/16

> Midterm 

## Lecture 13 - 2018/10/18

* TODO

## Lecture 13 - 2018/10/23

* Beginning of 3D computer vision
* Left handed frame (Z goes into canvas vs out of canvas)
* To go from 3D to 2D, we can just drop the z coordinate (orthogonal view?)
* Projection view - take depth into account by drawing images such that each ray goes to a single center of projection
* Plane: aX + bY + cZ = d
* f/Z - scale factor in perspective projection
* Multiplying plane by f/Z, we can rewrite to ax + by + cf = fd/Z
    * When Z &rarr; &infin;, ax = by + cf = 0, line at infinity
* Ground plane
    * Y = -h
    * y = fY/Z = -fh/Z (when Z &rarr; &infin;, y &rarr; 0)
    * aka 'horizon'