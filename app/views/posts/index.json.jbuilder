json.array! @posts, partial: "posts/post", as: :post



<div class="index-list">

  <% @posts.each do |post| %>
    <ul class="containig-posts">
        <li class="home-li text-center" id="posts-timeline">
          <div class="gravatar-list">
            <%= gravatar_for(post.user) %>
            <div class= "name-posted-list">
              <p><%= link_to post.user.name, post.user %> <%= link_to post.user.lastname, post.user %></p>
              <p class="time"><%= time_ago_in_words(post.created_at) %> ago. </p>
            </div>
          </div>

          <p class= "text-left timeline-content"><%= post.content%></p>
          <p class="like-content text-center">
            <svg version="1.0" xmlns="http://www.w3.org/2000/svg"
                width="1.1em" height="1em" viewBox="0 0 1200.000000 1419.000000"
                preserveAspectRatio="xMidYMid meet">

                <g transform="translate(0.000000,1419.000000) scale(0.100000,-0.100000)"
                  fill="red" stroke="none">
                  <path d="M2970 13410 c-560 -54 -1010 -269 -1419 -680 -398 -399 -634 -882
                  -717 -1465 -22 -150 -24 -493 -5 -650 83 -696 363 -1310 1078 -2369 222 -329
                  497 -711 983 -1366 1371 -1849 1954 -2697 2378 -3456 266 -478 426 -841 616
                  -1401 52 -153 107 -305 121 -337 22 -50 28 -57 39 -45 17 18 60 131 143 374
                  257 754 671 1536 1354 2562 430 645 779 1126 1463 2013 969 1257 1288 1717
                  1595 2300 315 596 490 1105 568 1655 26 187 26 678 -1 850 -64 416 -216 786
                  -452 1102 -82 108 -269 300 -389 396 -359 290 -696 426 -1245 503 -159 23
                  -660 26 -785 6 -440 -72 -879 -311 -1269 -691 -347 -339 -585 -700 -776 -1176
                  -88 -221 -166 -384 -186 -392 -41 -15 -138 136 -314 492 -77 154 -176 341
                  -220 415 -458 762 -1093 1215 -1880 1341 -144 23 -523 34 -680 19z"/>
                </g>
          </svg>
          <%= post.likes.count %> <%= (post.likes.count) == 1 ? 'Like' : 'Likes'%>
          <% if like_unlike(post) %>
            <%= button_to 'Unlike', post_like_path(post, like_unlike(post)), method: :delete %>
          <% else %>
            <%= button_to 'Like', post_likes_path(post), method: :post %>
          <% end %>
          </p>


          <h3 class="comments-theader">Comments (<%= post.comments.count %>)</h3>
          <% post.comments.each do |comment| %>
            <li class="comments-list" id="comments-timeline">
              <span class="user-name"><span><%= link_to comment.user.name, comment.user %></span>    <span><%= link_to comment.user.lastname, comment.user %></span></span>
              <span class="comment-text"><%= comment.text%></span>

              <span class="timestamp">
              <%= time_ago_in_words(comment.created_at) %> ago.

              <% if authenticated_comment?(comment.user.name) %>
                <%= link_to "Delete", post_comment_path(post, comment), method: :delete, data: { confirm: "You sure?" } %>
              <% end %>
              <p class="like-content">
                <%= comment.likes.count %> <%= (comment.likes.count) == 1 ? 'Like' : 'Likes'%>
              </p>

              <% if like_unlike(comment) %>
                <%= button_to 'Unlike', post_comment_like_path(post, comment, like_unlike(comment)), method: :delete %>
              <% else %>
                <%= button_to 'Like', post_comment_likes_path(post.comments, comment), method: :post %>
              <% end %>
            </li>
          <% end %>
        </li>


    </ul>
    <% end %>
</div>
