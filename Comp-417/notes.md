# Comp 417

> [Course Website](http://www.cim.mcgill.ca/~dudek/417.html)

## Lecture 3 - 2018/09/12

* Motion planning - moving between places
    * Place - post/configuration
* 3-parameter representation: q = (x, y, &theta;)
    * 3-D workspace: (x, y, a, &alpha;, &beta;, &gamma;)]
* Manifold - surface embedded in a higher dimension
    * For each point q, there is a 1 to 1 map between neighborhood of q and cartesian space R<sup>n</sup>, where n is the dimension of C
* Chart - manifold map in local coordinate system
* Atlas - Set of charts covering dimension C
* Rotation Matrix
    * 3 by 3 matrix, where 
        * R<sup>T</sup> = R<sup>-1</sup> (orthogonal)
        * sum of squares of each row add to 1
        * dot product of each row and column is 0
        * determinant is &plusmn; 1