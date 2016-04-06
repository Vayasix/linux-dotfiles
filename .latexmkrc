### parameter ###
# %O: option
# %S: source file
# %B: bib file
$latex = 'platex -interaction=nonstopmode -kanji=utf-8 %O %S';
$bibtex = 'pbibtex -kanji=utf8 %O %B';
$dvipdf = 'dvipdfmx %O -o %D %S'; 

if ($^O eq 'darwin') {
    $pdf_previewer = 'open -a Preview %S';
} elsif ($^O eq 'linux') {
    $pdf_previewer = 'evince';
}
$preview_continuous_mode = 1;
#how to make pdf, 0(default):don't make pdf, 1:pdflatex, 2:ps2pdf, 3:dvipdf 
$pdf_mode = 3;
$pdf_update_method = 4;
$pdf_update_command = 'start evince %S';

# Prevent latexmk from removing PDF after typeset.
# $pvc_view_file_via_temporary = 0;

#-pv コンパイル終了後、$pdf_previewer で指定したものでPDFをプレビューする。
#-pvc -pv に加え、texファイルを監視し続け、変更を検知したら再度コンパイルしてくれる。
#-c 途中で生成した中間ファイル（.log, .auxなど）を削除してくれる。
#-C 生成したファイル（.pdf, .dviなど）を削除してくれる。

#Good link
#http://konn-san.com/prog/why-not-latexmk.html
