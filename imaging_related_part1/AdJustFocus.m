function AdJustFocus(handles,MoveDistance,MoveDirection)

% MoveDirection, 1 up, -1 down
SZX2=handles.my.SZX2;
% fprintf(SZX2, '%s\r\n', '3LOG OUT');
% fprintf(SZX2, '%s\r\n', '3LOG IN');
pause(1)
if MoveDirection==1
    MoveString=['3FCH ' 'F,' num2str(MoveDistance)];
elseif MoveDirection==-1
    MoveString=['3FCH ' 'N,' num2str(MoveDistance)];
end
fprintf(SZX2, '%s\r\n', MoveString);

end
