// ==UserScript==
// @name         Lycoris Reader View
// @description  Firefox-style Reader Mode (clean article text, zero clutter, zero RAM)
// @version      1.0
// ==/UserScript==
(function() {
    window.toggleLycorisReaderMode = function() {
        if (document.getElementById('lycoris-reader-style')) {
            // Revert
            location.reload();
            return;
        }
        const article = document.querySelector('article') || document.querySelector('main') || document.querySelector('.post-content') || document.body;
        const title = document.querySelector('h1')?.innerText || document.title;
        
        // Extract paragraphs and headings only
        const nodes = article.querySelectorAll('h1, h2, h3, p, img');
        let contentHtml = '';
        nodes.forEach(n => {
            if (n.tagName === 'IMG' && n.src) {
                contentHtml += `<img src="${n.src}" style="max-width:100%; border-radius:8px; margin:16px 0;" />`;
            } else if (n.innerText && n.innerText.trim().length > 0) {
                contentHtml += `<${n.tagName.toLowerCase()}>${n.innerHTML}</${n.tagName.toLowerCase()}>`;
            }
        });

        document.head.innerHTML = `
            <meta charset="utf-8">
            <title>${title}</title>
            <style id="lycoris-reader-style">
                body {
                    background-color: #23222a !important;
                    color: #e2e1e8 !important;
                    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Georgia, serif !important;
                    line-height: 1.75 !important;
                    font-size: 18px !important;
                    max-width: 680px !important;
                    margin: 40px auto !important;
                    padding: 0 20px 80px 20px !important;
                }
                h1 { font-size: 32px !important; color: #ffffff !important; line-height: 1.25 !important; margin-bottom: 24px !important; }
                h2 { font-size: 24px !important; color: #f87171 !important; margin-top: 32px !important; }
                p { margin-bottom: 20px !important; }
                a { color: #f87171 !important; }
            </style>
        `;
        document.body.innerHTML = `<h1>${title}</h1>${contentHtml}`;
    };
})();
