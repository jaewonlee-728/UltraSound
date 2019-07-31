% =========================================================================
%> @brief 
%>  Get transformation matrix and spacing of Image Message
%>  @param: Input  >> m       : tempoary matrix from binary buffer
%>  @param: Output >> matrix  : Transformation matrix of ImageMessage
%>  @param: Output >> spacing : spacing values of ImageMessage
% =========================================================================

% /***************************************************************************
% Copyright 
% MUSiiC Laboratory
% Hyun-Jae Kang,Emad M Boctor
% Johns Hopkins Medical Institutions
% Department of Radiology, Division of Medical Imaging Physics
% 
% For commercial use/licensing, please contact Emad Boctor, Ph.D. at eboctor@jhmi.edu.
% ***************************************************************************/
function [matrix, spacing] = GetIGTLImageMatrix(m)

spacing(1) = norm(m(1:3));
spacing(2) = norm(m(4:6));
spacing(3) = norm(m(7:9));

norm_i = m(1:3)/spacing(1);
norm_j = m(4:6)/spacing(2);
norm_k = m(7:9)/spacing(3);

matrix = eye(4,4);

matrix(1:3,1) = norm_i;
matrix(1:3,2) = norm_j;
matrix(1:3,3) = norm_k;
matrix(1:3,4) = m(10:12);
end
