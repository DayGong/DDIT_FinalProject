/**
 * 일기장에서 사용되는 공통 코드
 * <script type="text/javascript" src="/resources/js/diaryCommon.js"></script>
 */
 
 /** 이모티콘 이미지를 반환하는 메서드 */
function fn_emotionImg (emo) {
    let  html = "";

    switch(emo) {
        case "최고":
            html = `<img src="/resources/images/classRoom/diary/best.png" class="emotionImg">`;
            break;
        case "좋아":
            html = `<img src="/resources/images/classRoom/diary/good.png" class="emotionImg">`;
            break;
        case "보통":
            html = `<img src="/resources/images/classRoom/diary/normal.png" class="emotionImg">`;
            break;
        case "나빠":
            html = `<img src="/resources/images/classRoom/diary/soso.png" class="emotionImg">`;
            break;
        case "최악":
            html = `<img src="/resources/images/classRoom/diary/worst.png" class="emotionImg">`;
            break;
        default:
            break;	
    }

    return html;
}
