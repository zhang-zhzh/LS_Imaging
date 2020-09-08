% light sheet

function mouse_control_ExternalLightSheetMode(flag)

import java.awt.Robot;
import java.awt.event.*;
mouse = Robot;

! C:\Program Files\HCImageLive\HCImageLive.exe
% pause(0.2);

if flag==1 % Light sheet mode, ExposureTime=50ms;LineInterval=30us;
    % capture
    mouse.mouseMove(29, 131);
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    
    % LineInterval=30us
    mouse.mouseMove(132, 664);
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    
    mouse.keyPress(java.awt.event.KeyEvent.VK_BACK_SPACE);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_BACK_SPACE);
    mouse.keyPress(java.awt.event.KeyEvent.VK_3);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_3);
    mouse.keyPress(java.awt.event.KeyEvent.VK_0);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_0);
    mouse.keyPress(java.awt.event.KeyEvent.VK_ENTER);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_ENTER);
    
    % ExposureTime=50ms
    mouse.mouseMove(341, 416);
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    
    mouse.keyPress(java.awt.event.KeyEvent.VK_BACK_SPACE);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_BACK_SPACE);
    mouse.keyPress(java.awt.event.KeyEvent.VK_5);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_5);
    mouse.keyPress(java.awt.event.KeyEvent.VK_0);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_0);
    mouse.keyPress(java.awt.event.KeyEvent.VK_ENTER);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_ENTER);
    
    % sequence
    mouse.mouseMove(85, 131);
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    
    

else % Light sheet mode, ExposureTime=10ms;LineInterval=10us;
    % capture
    mouse.mouseMove(29, 131);
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    
    % LineInterval=10us
    mouse.mouseMove(132, 664);
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    
    mouse.keyPress(java.awt.event.KeyEvent.VK_BACK_SPACE);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_BACK_SPACE);
    mouse.keyPress(java.awt.event.KeyEvent.VK_1);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_1);
    mouse.keyPress(java.awt.event.KeyEvent.VK_0);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_0);
    mouse.keyPress(java.awt.event.KeyEvent.VK_ENTER);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_ENTER);
    
    % ExposureTime=18ms
    mouse.mouseMove(341, 416);
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    
    mouse.keyPress(java.awt.event.KeyEvent.VK_BACK_SPACE);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_BACK_SPACE);
    mouse.keyPress(java.awt.event.KeyEvent.VK_1);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_1);
    mouse.keyPress(java.awt.event.KeyEvent.VK_0);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_0);
    mouse.keyPress(java.awt.event.KeyEvent.VK_ENTER);
    mouse.keyRelease(java.awt.event.KeyEvent.VK_ENTER);
    
    % sequence
    mouse.mouseMove(85, 131);
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    
    
    
    
    
   
    
    
end
end



% C = get(0, 'PointerLocation')

% https://blog.csdn.net/u011389706/article/details/57399942
% https://docs.oracle.com/javase/8/docs/api/java/awt/Robot.html