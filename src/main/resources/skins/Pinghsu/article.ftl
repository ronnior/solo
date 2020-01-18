<#--

    Solo - A small and beautiful blogging system written in Java.
    Copyright (c) 2010-present, b3log.org

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

-->
<#include "../../common-template/macro-common_head.ftl">
<#include "macro-comments.ftl">
<#include "../../common-template/macro-comment_script.ftl">
<!DOCTYPE html>
<html>
<head>
    <@head title="${article.articleTitle} - ${blogTitle}" description="${article.articleAbstract?html}">
        <link rel="stylesheet"
              href="${staticServePath}/skins/${skinDirName}/css/base.css?${staticResourceVersion}"/>
        <#if previousArticlePermalink??>
            <link rel="prev" title="${previousArticleTitle}" href="${servePath}${previousArticlePermalink}">
        </#if>
        <#if nextArticlePermalink??>
            <link rel="next" title="${nextArticleTitle}" href="${servePath}${nextArticlePermalink}">
        </#if>
    </@head>
</head>
<body>
<#include "header.ftl">
<main id="pjax" class="fn__flex-1">
    <#if pjax><!---- pjax {#pjax} start ----></#if>
    <div class="post wrapper wrapper--miner">
        <h2 class="item__title">
            <a rel="bookmark" href="${servePath}${article.articlePermalink}">
                ${article.articleTitle}
            </a>
            <#if article.articlePutTop>
                <sup>
                    ${topArticleLabel}
                </sup>
            </#if>
        </h2>
        <div class="ft__fade item__meta">
            <#if article.articleCreateDate?datetime != article.articleUpdateDate?datetime>
                Updated on
            <#else>
                Published on
            </#if>
            <time>
                <#setting locale="en_US">
                ${article.articleUpdateDate?string["MMM d, yyyy"]}
            </time>
            <#if article.category??>
                in <a href="${servePath}/category/${article.category.categoryURI}">${article.category.categoryTitle}</a>
            </#if>
            with <span data-uvstaturl="${servePath}${article.articlePermalink}">${article.articleViewCount}</span> views
            <#if commentable>
                and <a href="#b3logsolocomments"><span data-uvstatcmt="${article.oId}">${article.articleCommentCount}</span> comments</a>
            </#if>
        </div>
        <div class="item__tags">
            <#list article.articleTags?split(",") as articleTag>
                <a rel="tag" class="tag tag--${articleTag_index}" href="${servePath}/tags/${articleTag?url('UTF-8')}">
                    <b># ${articleTag}</b>
                </a>
            </#list>
        </div>
        <div class="vditor-reset">
            ${article.articleContent}
            <#if "" != article.articleSign.signHTML?trim>
                <div>
                    ${article.articleSign.signHTML}
                </div>
            </#if>
        </div>
    </div>
    <div class="post__toc">
        <#if article?? && article.articleToC?? && article.articleToC?size &gt; 0>
            <#include "../../common-template/toc.ftl"/>
        </#if>
    </div>
    <div class="body--gray post__gray">
        <div class="wrapper comment">
            <#if commentable>
                <div id="b3logsolocomments"></div>
                <div id="vcomment" style="padding: 30px 0;" data-name="${article.authorName}" data-postId="${article.oId}"></div>
                <#if !staticSite>
                    <div id="soloComments" style="display: none;">
                        <@comments commentList=articleComments article=article></@comments>
                    </div>
                </#if>
            </#if>

            <div class="post__list fn__flex">
                <div class="fn__flex-1">
                    <div id="externalRelevantArticles"></div>
                </div>
                <div class="post__list-mid fn__flex-1">
                    <div id="randomArticles"></div>
                </div>
                <div class="fn__flex-1">
                    <div id="relevantArticles"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="post__fix">
        <div class="wrapper">
            <span class="post__share mobile__none">
                Share
                <span class="tag tag--4" data-type="weibo">WeiBo</span>
                <span class="tag tag--5" data-type="twitter">Twitter</span>
                <span class="tag tag--6" data-type="qqz">QZone</span>
                <span class="post__code tag tag--7"
                      data-type="wechat"
                      data-title="${article.articleTitle}"
                      data-blogtitle="${blogTitle}"
                      data-url="${servePath}${article.articlePermalink}"
                      data-avatar="${article.authorThumbnailURL}">WeChat</span>
            </span>
            <span class="post__arrow">
                <#if previousArticlePermalink??>
                    <a href="${servePath}${previousArticlePermalink}" rel="prev"
                       class="vditor-tooltipped__n vditor-tooltipped"
                       pjax-title="${previousArticleTitle}"
                       aria-label="${previousArticleLabel}: ${previousArticleTitle}">←</a>
                </#if>

                <#if nextArticlePermalink??>
                    <a href="${servePath}${nextArticlePermalink}" rel="next"
                       class="vditor-tooltipped__n vditor-tooltipped"
                       pjax-title="${nextArticleTitle}"
                       aria-label="${nextArticleLabel}: ${nextArticleTitle}">→</a>
                </#if>
                <a href="javascript:Util.goTop()" class="vditor-tooltipped__n vditor-tooltipped"
                   aria-label="${goTopLabel}">↑</a>
                <a href="javascript:Util.goBottom()" class="vditor-tooltipped__n vditor-tooltipped"
                   aria-label="${goBottomLabel}">↓</a>
            </span>
        </div>
    </div>
    <#if pjax><!---- pjax {#pjax} end ----></#if>
</main>
<#include "footer.ftl">

<#if pjax><!---- pjax {#pjax} start ----></#if>
<@comment_script oId=article.oId commentable=article.commentable>
    page.tips.externalRelevantArticlesDisplayCount = "${externalRelevantArticlesDisplayCount}";
    <#if 0 != randomArticlesDisplayCount>
    page.loadRandomArticles('<h3>RECOMMEND POSTS</h3>');
    </#if>
    <#if 0 != externalRelevantArticlesDisplayCount>
    page.loadExternalRelevantArticles("<#list article.articleTags?split(",") as articleTag>${articleTag}<#if articleTag_has_next>,</#if></#list>",
    '<h3>HACPAI POSTS</h3>');
    </#if>
    <#if 0 != relevantArticlesDisplayCount>
    page.loadRelevantArticles('${article.oId}', '<h3>RELEVANT POSTS</h3>');
    </#if>
Skin.initArticle()
</@comment_script>
<#if pjax><!---- pjax {#pjax} end ----></#if>
</body>
</html>
