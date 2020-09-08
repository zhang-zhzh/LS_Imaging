%% -94        -123        -233        -232        -529        -728
%% -1389       -1779       -3433       -5587
%% 0.63 _ 0.8
fprintf(SZX2, '%s\r\n', '3FCH N,5587');
%% 0.8 _ 1
fprintf(SZX2, '%s\r\n', '3FCH N,3433');
%% 1 _ 1.25
fprintf(SZX2, '%s\r\n', '3FCH N,1779');
%% 1.25 _ 1.6
fprintf(SZX2, '%s\r\n', '3FCH N,1389');
%% 1.6 _ 2
fprintf(SZX2, '%s\r\n', '3FCH N,728');
%% 2 _ 2.5
fprintf(SZX2, '%s\r\n', '3FCH N,529');
%% 2.5 _ 3.2
fprintf(SZX2, '%s\r\n', '3FCH N,232');
%% 3.2 _ 4
fprintf(SZX2, '%s\r\n', '3FCH N,233');
%% 4 _ 5
fprintf(SZX2, '%s\r\n', '3FCH N,123');
%% 5 _ 6.3
fprintf(SZX2, '%s\r\n', '3FCH N,94');

%% reverse

%% 0.63 _ 0.8
fprintf(SZX2, '%s\r\n', '3FCH F,5587');
%% 0.8 _ 1
fprintf(SZX2, '%s\r\n', '3FCH F,3433');
%% 1 _ 1.25
fprintf(SZX2, '%s\r\n', '3FCH F,1779');
%% 1.25 _ 1.6
fprintf(SZX2, '%s\r\n', '3FCH F,1389');
%% 1.6 _ 2
fprintf(SZX2, '%s\r\n', '3FCH F,728');
%% 2 _ 2.5
fprintf(SZX2, '%s\r\n', '3FCH F,529');
%% 2.5 _ 3.2
fprintf(SZX2, '%s\r\n', '3FCH F,232');
%% 3.2 _ 4
fprintf(SZX2, '%s\r\n', '3FCH F,233');
%% 4 _ 5
fprintf(SZX2, '%s\r\n', '3FCH F,123');
%% 5 _ 6.3
fprintf(SZX2, '%s\r\n', '3FCH F,94');
%%


