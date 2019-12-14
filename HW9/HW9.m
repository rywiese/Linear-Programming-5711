clc;

% Problem 1
clear;
v = 10;
a = [4; 4; 5; 7];

% IP
cvx_begin
cvx_solver mosek;
integer variables x(4,4) y(4)
    minimize sum(y)
    subject to
		sum(x(1,:)) == 1;
		sum(x(2,:)) == 1;
		sum(x(3,:)) == 1;
		sum(x(4,:)) == 1;
		
		dot(x(:,1), a) <= v;
		dot(x(:,2), a) <= v;
		dot(x(:,3), a) <= v;
		dot(x(:,4), a) <= v;
		
		y(1) >= x(1,1);
		y(1) >= x(2,1);
		y(1) >= x(3,1);
		y(1) >= x(4,1);
		y(2) >= x(1,2);
		y(2) >= x(2,2);
		y(2) >= x(3,2);
		y(2) >= x(4,2);
		y(3) >= x(1,3);
		y(3) >= x(2,3);
		y(3) >= x(3,3);
		y(3) >= x(4,3);
		y(4) >= x(1,4);
		y(4) >= x(2,4);
		y(4) >= x(3,4);
		y(4) >= x(4,4);
		
		x <= 1;
		x >= 0;
		y <= 1;
		y >= 0;

cvx_end
x
y

% LP Relaxation
cvx_begin
variables x(4,4) y(4)
minimize sum(y)
subject to
	sum(x(1,:)) == 1;
	sum(x(2,:)) == 1;
	sum(x(3,:)) == 1;
	sum(x(4,:)) == 1;
	
	dot(x(:,1), a) <= v;
	dot(x(:,2), a) <= v;
	dot(x(:,3), a) <= v;
	dot(x(:,4), a) <= v;
	
	y(1) >= x(1,1);
	y(1) >= x(2,1);
	y(1) >= x(3,1);
	y(1) >= x(4,1);
	y(2) >= x(1,2);
	y(2) >= x(2,2);
	y(2) >= x(3,2);
	y(2) >= x(4,2);
	y(3) >= x(1,3);
	y(3) >= x(2,3);
	y(3) >= x(3,3);
	y(3) >= x(4,3);
	y(4) >= x(1,4);
	y(4) >= x(2,4);
	y(4) >= x(3,4);
	y(4) >= x(4,4);
	
	x <= 1;
	x >= 0;
	y <= 1;
	y >= 0;

cvx_end
x
y

% Problem 2
clear;
B = [1; 2; 3];
v = [2; 1; 3; 2; 2];
S = [
	1, 1, 0;
	0, 0, 1;
	1, 0, 1;
	0, 1, 1;
	0, 1, 0;
];

cvx_begin
cvx_solver mosek;
integer variables x(5)
    maximize dot(x, v)
    subject to
		dot(x, S(:, 1)) <= B(1);
		dot(x, S(:, 2)) <= B(2);
		dot(x, S(:, 3)) <= B(3);

		x >= 0;
		x <= 1;
cvx_end
x

cvx_begin
variables x(5)
    maximize dot(x, v)
    subject to
		dot(x, S(:, 1)) <= B(1);
		dot(x, S(:, 2)) <= B(2);
		dot(x, S(:, 3)) <= B(3);

		x >= 0;
		x <= 1;
cvx_end
x

% Problem 3
clear;

% Actual answer
%cvx_begin
%cvx_solver mosek;
%integer variables x(2)
%    maximize 100 * x(1) + 150 * x(2)
%    subject to
%		8000 * x(1) + 4000 * x(2) <= 40000;
%		15 * x(1) + 30 * x(2) <= 200;
%		x >= 0;
%cvx_end
%x

% Start of branch and bound

% Root
cvx_begin
variables x(2)
    maximize 100 * x(1) + 150 * x(2)
    subject to
		8000 * x(1) + 4000 * x(2) <= 40000;
		15 * x(1) + 30 * x(2) <= 200;
		x >= 0;
cvx_end
x

% Root.left
cvx_begin
variables x(2)
    maximize 100 * x(1) + 150 * x(2)
    subject to
		8000 * x(1) + 4000 * x(2) <= 40000;
		15 * x(1) + 30 * x(2) <= 200;
		x >= 0;
		x(1) >= 3
cvx_end
x

% Root.right
cvx_begin
variables x(2)
    maximize 100 * x(1) + 150 * x(2)
    subject to
		8000 * x(1) + 4000 * x(2) <= 40000;
		15 * x(1) + 30 * x(2) <= 200;
		x >= 0;
		x(1) <= 2
cvx_end
x

% Root.right.left
cvx_begin
variables x(2)
    maximize 100 * x(1) + 150 * x(2)
    subject to
		8000 * x(1) + 4000 * x(2) <= 40000;
		15 * x(1) + 30 * x(2) <= 200;
		x >= 0;
		x(1) <= 2
		x(2) >= 6
cvx_end
x

% Root.right.right
cvx_begin
variables x(2)
    maximize 100 * x(1) + 150 * x(2)
    subject to
		8000 * x(1) + 4000 * x(2) <= 40000;
		15 * x(1) + 30 * x(2) <= 200;
		x >= 0;
		x(1) <= 2
		x(2) <= 5
cvx_end
x

% Root.right.left.left
cvx_begin
variables x(2)
    maximize 100 * x(1) + 150 * x(2)
    subject to
		8000 * x(1) + 4000 * x(2) <= 40000;
		15 * x(1) + 30 * x(2) <= 200;
		x >= 0;
		x(1) <= 2
		x(2) >= 6
		x(1) >= 2
cvx_end
x

% Root.right.left.right
cvx_begin
variables x(2)
    maximize 100 * x(1) + 150 * x(2)
    subject to
		8000 * x(1) + 4000 * x(2) <= 40000;
		15 * x(1) + 30 * x(2) <= 200;
		x >= 0;
		x(1) <= 1
		x(2) >= 6
cvx_end
x

% Root.right.left.right.left
cvx_begin
variables x(2)
    maximize 100 * x(1) + 150 * x(2)
    subject to
		8000 * x(1) + 4000 * x(2) <= 40000;
		15 * x(1) + 30 * x(2) <= 200;
		x >= 0;
		x(1) <= 1
		x(2) >= 7
cvx_end
x

% Root.right.left.right.right
cvx_begin
variables x(2)
    maximize 100 * x(1) + 150 * x(2)
    subject to
		8000 * x(1) + 4000 * x(2) <= 40000;
		15 * x(1) + 30 * x(2) <= 200;
		x >= 0;
		x(1) <= 1
		x(2) <= 6
cvx_end
x