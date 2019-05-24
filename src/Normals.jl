module Normals

using Images

function NormalGen_Sobel(_img; filter=[-0.5, 0, 0.5], SpaceMapping=ZeroOneSpaceMapping)
    width, height = size(_img);
    oldimg        = RGB{Float64}.(_img)
    newimg        = copy(RGB{Float64}.(_img))
    bounds        = Int64.(floor(length(filter)/2))
    
    for y in 1:height
        for x in 1:width   
            xsum   = 0.0   
            ysum   = 0.0
            count = 1
            for s in -bounds:bounds
                if(x+s>=1 && x+s<=width)
                    xsum = xsum +  (filter[count] * ( RGBSum( oldimg[x+s, y   ] ) / 3.0 ))   
                end
                
                if(y+s>=1 && y+s<=height)
                    ysum = ysum +  (filter[count] * ( RGBSum( oldimg[x, y+s   ] ) / 3.0 ))
                end
                count = count+1         
            end 
            
            col = SpaceMapping([ xsum, ysum, 1.0])
            col = normalize(col)
            newimg[x,y] = RGB( col[1], col[2], col[3])
        end
    end
    newimg
end
NormalGen = NormalGen_Sobel

export NormalGen_Sobel, NormalGen


end # module
