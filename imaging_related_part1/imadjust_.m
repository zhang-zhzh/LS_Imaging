function imadjust_(src, e, objH)
    objH.CData = imadjust(e.Data,stretchlim(e.Data,0));
end