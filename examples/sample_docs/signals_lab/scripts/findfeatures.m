function [result] = findfeatures(filename,dctlength)
%-----------------------------------------------------
%
% function [result] = findfeatures(filename,dctlength)
% filename: example 's1.pgm'
% dctlength: length of desired dct
% example: [result]=findfeatures('s1.pgm',35);
%
%-----------------------------------------------------
% Read image
[ingresso]=imread(filename);
Lout = dctlength;

% Do zig-zag scanning
[dimx,dimy] = size(ingresso);
dimprod     = dimx*dimy;
zigzag = zeros(dimx,dimy);
ii = 1;
jj = 1;
zigzag(ii,jj) = 1;
slittox = 0;
slittoy = 1;
last    = 0;
cont    = 2;

while cont<dimprod
    if slittox == 1 && (ii+1)<=dimx
        ii = ii+1;
        jj = jj;
        zigzag(ii,jj)=cont;
        cont = cont+1;
        slittox = 0;
        last    = 1;
        continue;
    end
    if slittox == 1 && (ii+1)>dimx && (jj+1<=dimy)
        ii = ii;
        jj = jj+1;
        zigzag(ii,jj)=cont;
        cont = cont+1;
        slittox = 0;
        last    = 1;
        continue;
    end

    if slittoy == 1 && (jj+1)<=dimy
        ii = ii;
        jj = jj+1;
        zigzag(ii,jj)=cont;
        cont = cont+1;
        slittoy = 0;
        last    = 0;
        continue;
    end
    if slittoy == 1 && (jj+1)>dimy && (ii+1<=dimx)
        ii = ii+1;
        jj = jj;
        zigzag(ii,jj)=cont;
        cont = cont+1;
        slittoy = 0;
        last    = 0;
        continue;
    end

    if (slittox == 0 && slittoy == 0) && last == 1
        if ii-1>=1 && jj+1<=dimy
            ii=ii-1;
            jj=jj+1;
            zigzag(ii,jj)=cont;
            cont = cont+1;
            continue;
        else
            slittox = 0;
            slittoy = 1;
            continue;
        end
    end

    if (slittox == 0 && slittoy == 0) && last == 0
        if ii+1<=dimx && jj-1>=1
            ii=ii+1;
            jj=jj-1;
            zigzag(ii,jj)=cont;
            cont = cont+1;
            continue;
        else
            slittox = 1;
            slittoy = 0;
            continue;
        end
    end
end
zigzag(dimx,dimy)=dimprod;
%-----------------------------------------------------
%-----------------------------------------------------
t                = dct2(ingresso);
vettore_t        = t(:);
vettore_t_zigzag = zeros(size(vettore_t));
vettore_zigzag   = zigzag(:);
for ii=1:length(vettore_t)
    vettore_t_zigzag(vettore_zigzag(ii)) = ...
    vettore_t(ii);
end
result = vettore_t_zigzag(2:Lout+1);
%-----------------------------------------------------
%-----------------------------------------------------
%-----------------------------------------------------
