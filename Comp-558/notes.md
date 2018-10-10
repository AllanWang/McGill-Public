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
    * Navigations systems
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

**TODO**

## Lecture 7 - 2018/09/25

**TODO**

## Lecture 8 - 2018/09/27

* Gaussian pyramid - smoothing + subsampling
* Think of &nabla;I as 2 x 1 matrix (or a column vector)
* StructureTensor is a 2 x 2 matrix given by &nabla;I (&nabla;I)<sup>T</sup>
* The eigenvalues & eigenvectors of matrix reveal invariant geometric properties
    * Order the eigenvalues in descending order (&lambda;<sub>1</sub> &ge; &lambda;<sub>2</sub> > 0)
    * Then e<sub>1</sub> is the direction aligned with the local gradient
    * Special case is when &lambda;<sub>2</sub> = 0, I is constant along e<sub>2</sub>
* To find corners, find a way to capture locations where I(x<sub>0</sub>, y<sub>0</sub>) is different from that of its neighbours
    * Keep in mind
        * We always 'smooth' a little bit (convolution with a kernel) so that &nabla;I is acceptable
        * I(x<sub>0</sub> + &Delta;x, y<sub>0</sub> + &Delta;y)

## Lecture 9 - 2018/08/02

* Midterm material ends this week
* Normalized correlation - d<sub>correl</sub>(H<sub>1</sub>, H<sub>2</sub>) = &Sigma;(H'<sub>1</sub>(i) &centerdot; H'<sub>2</sub>) / &radic;(&Sigma;(H'<sub>1</sub><sup>2</sup>(i) &centerdot; H'<sub>2</sub><sup>2</sup>(i)))
    * 1 - perfect match
    * -1 - perfect mismatch
    * 0 - no correlation
* Chi-square - 
* Bhattacharya
    * 0 - perfect match
    * 1 - total mismatch
* Histogram equalization 
* Histogram of oriented gradients
    * Compute gradients
    * Divide into bins by orientation
    * Count number of entries in each bin

## Lecture 10 - 2018/08/04

**TODO**

## Lecture 11 - 2018/08/09

Midterm next week until lecture 10

* CNNs
    * Convolutional layers (MLPs)
    * Activation functions, tanh ,sigmoid, RELV
    * Pooling, avg, max, others
* Backward Propagation 
    * Gol is to estimate W and b to minimize sum of square error loss function
* Review properties of 2nd moment matrix
* 