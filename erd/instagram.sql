
instragram
2000
100%
Table: 13

CREATE TABLE comments
(
  id         BIGINT   NOT NULL AUTO_INCREMENT COMMENT '코멘트 id',
  post_id    BIGINT   NOT NULL COMMENT '포스트id',
  user_id    BIGINT   NOT NULL COMMENT '사용자id',
  text       TEXT     NOT NULL COMMENT '코멘트 내용',
  created_at DATETIME NOT NULL COMMENT '등록일',
  updated_at DATETIME NULL     COMMENT '수정일',
  PRIMARY KEY (id)
) COMMENT '코멘트 테이블';

ALTER TABLE comments
  ADD CONSTRAINT UQ_id UNIQUE (id);

CREATE TABLE follows
(
  follower_user_id BIGINT   NOT NULL COMMENT '팔로워id',
  followee_user_id BIGINT   NOT NULL COMMENT '팔로잉id',
  followed_at      DATETIME NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  PRIMARY KEY (follower_user_id, followee_user_id)
) COMMENT '팔로워 테이블';

CREATE TABLE hashtags
(
  id          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '해시태그id',
  name        VARCHAR(100) NOT NULL COMMENT '태그명',
  description VARCHAR(255) NULL     COMMENT '해시태그 설명',
  created_at  DATETIME     NOT NULL COMMENT '등록일',
  PRIMARY KEY (id)
) COMMENT '해시태그 테이블';

ALTER TABLE hashtags
  ADD CONSTRAINT UQ_id UNIQUE (id);

CREATE TABLE images
(
  id         BIGINT       NOT NULL AUTO_INCREMENT COMMENT '이미지id',
  post_id    BIGINT       NOT NULL COMMENT '포스트id',
  image_url  VARCHAR(100) NOT NULL COMMENT '이미지 url',
  alt_text   VARCHAR(100) NOT NULL COMMENT '이미지 설명',
  order_num  int          NOT NULL COMMENT '정렬순서',
  created_at DATETIME     NOT NULL COMMENT '등록일자',
  PRIMARY KEY (id)
) COMMENT '이미지 테이블';

ALTER TABLE images
  ADD CONSTRAINT UQ_id UNIQUE (id);

CREATE TABLE likes
(
  id      BIGINT NOT NULL AUTO_INCREMENT COMMENT '좋아요 id',
  post_id BIGINT NOT NULL COMMENT '포스트id',
  user_id BIGINT NOT NULL COMMENT '사용자id',
  PRIMARY KEY (id)
) COMMENT '좋아요 테이블';

ALTER TABLE likes
  ADD CONSTRAINT UQ_id UNIQUE (id);

CREATE TABLE message_deleted
(
  message_id BIGINT   NOT NULL COMMENT '메시지 id',
  user_id    BIGINT   NOT NULL COMMENT '사용자id',
  deleted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '삭제일'
) COMMENT '메시지 삭제 테이블';

CREATE TABLE message_reads
(
  room_id          BIGINT NOT NULL COMMENT '채팅방id',
  user_id          BIGINT NOT NULL COMMENT '사용자id',
  last_read_msg_id BIGINT NULL     COMMENT '마지막읽은 id'
) COMMENT '메시지 읽기확인 테이블';

CREATE TABLE messages
(
  id         BIGINT      NOT NULL AUTO_INCREMENT COMMENT '메시지 id',
  room_id    BIGINT      NOT NULL COMMENT '채팅방id',
  sender_id  BIGINT      NOT NULL COMMENT '사용자id',
  msg_type   VARCHAR(16) NOT NULL COMMENT '메시지형식',
  content    TEXT        NULL     COMMENT '내용',
  sent_at    DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '보낸날짜',
  is_deleted BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '삭제여부',
  PRIMARY KEY (id)
) COMMENT '메시지 내용 테이블';

ALTER TABLE messages
  ADD CONSTRAINT UQ_id UNIQUE (id);

CREATE TABLE post_hashtags
(
  post_id    BIGINT   NOT NULL COMMENT '포스트id',
  hashtag_id BIGINT   NOT NULL COMMENT '해시태그id',
  created_at DATETIME NOT NULL COMMENT '등록일',
  PRIMARY KEY (post_id, hashtag_id)
);

ALTER TABLE post_hashtags
  ADD CONSTRAINT UQ_hashtag_id UNIQUE (hashtag_id);

CREATE TABLE posts
(
  id         BIGINT       NOT NULL AUTO_INCREMENT COMMENT '포스트id',
  user_id    BIGINT       NOT NULL COMMENT 'user id',
  title      VARCHAR(255) NOT NULL COMMENT '제목',
  content    TEXT         NOT NULL COMMENT '내용',
  created_at DATETIME     NOT NULL COMMENT '등록일',
  updated_at DATETIME     NULL     COMMENT '수정일',
  PRIMARY KEY (id)
) COMMENT 'post 테이블';

ALTER TABLE posts
  ADD CONSTRAINT UQ_id UNIQUE (id);

CREATE TABLE rooms
(
  id              BIGINT   NOT NULL AUTO_INCREMENT COMMENT '채팅방id',
  user_id1        BIGINT   NOT NULL COMMENT '사용자id',
  user_id2        BIGINT   NOT NULL COMMENT '사용자id',
  last_message_id BIGINT   NOT NULL COMMENT '메시지 id',
  created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일',
  PRIMARY KEY (id)
) COMMENT '채팅방 테이블';

ALTER TABLE rooms
  ADD CONSTRAINT UQ_id UNIQUE (id);

CREATE TABLE users
(
  id              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '사용자id',
  email           VARCHAR(100) NOT NULL COMMENT '이메일',
  password        VARCHAR(50)  NOT NULL COMMENT '비밀번호',
  name            VARCHAR(50)  NULL     COMMENT '이름',
  phone           INT          NULL     COMMENT '전화번호',
  profile_photo   VARCHAR(100) NULL     COMMENT '프로필사진',
  email_cert_code VARCHAR(20)  NULL     COMMENT '이메일인증코드',
  email_cert_date DATETIME     NULL     COMMENT '이메일인증일',
  created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '가입일자',
  updated_at      DATETIME     NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '수정일자',
  PRIMARY KEY (id)
) COMMENT '사용자 테이블';

ALTER TABLE users
  ADD CONSTRAINT UQ_id UNIQUE (id);

CREATE TABLE users_denied
(
  denier_use_id  BIGINT   NOT NULL COMMENT '차단요청id',
  denied_user_id BIGINT   NOT NULL COMMENT '차단 id',
  denied_at      DATETIME NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '차단일',
  PRIMARY KEY (denier_use_id, denied_user_id)
) COMMENT '접근차단테이블';

ALTER TABLE users_denied
  ADD CONSTRAINT FK_users_TO_users_denied
    FOREIGN KEY (denier_use_id)
    REFERENCES users (id);

ALTER TABLE users_denied
  ADD CONSTRAINT FK_users_TO_users_denied1
    FOREIGN KEY (denied_user_id)
    REFERENCES users (id);

ALTER TABLE follows
  ADD CONSTRAINT FK_users_TO_follows
    FOREIGN KEY (follower_user_id)
    REFERENCES users (id);

ALTER TABLE follows
  ADD CONSTRAINT FK_users_TO_follows1
    FOREIGN KEY (followee_user_id)
    REFERENCES users (id);

ALTER TABLE posts
  ADD CONSTRAINT FK_users_TO_posts
    FOREIGN KEY (user_id)
    REFERENCES users (id);

ALTER TABLE post_hashtags
  ADD CONSTRAINT FK_posts_TO_post_hashtags
    FOREIGN KEY (post_id)
    REFERENCES posts (id);

ALTER TABLE post_hashtags
  ADD CONSTRAINT FK_hashtags_TO_post_hashtags
    FOREIGN KEY (hashtag_id)
    REFERENCES hashtags (id);

ALTER TABLE images
  ADD CONSTRAINT FK_posts_TO_images
    FOREIGN KEY (post_id)
    REFERENCES posts (id);

ALTER TABLE likes
  ADD CONSTRAINT FK_posts_TO_likes
    FOREIGN KEY (post_id)
    REFERENCES posts (id);

ALTER TABLE comments
  ADD CONSTRAINT FK_posts_TO_comments
    FOREIGN KEY (post_id)
    REFERENCES posts (id);

ALTER TABLE comments
  ADD CONSTRAINT FK_users_TO_comments
    FOREIGN KEY (user_id)
    REFERENCES users (id);

ALTER TABLE message_deleted
  ADD CONSTRAINT FK_users_TO_message_deleted
    FOREIGN KEY (user_id)
    REFERENCES users (id);

ALTER TABLE messages
  ADD CONSTRAINT FK_users_TO_messages
    FOREIGN KEY (sender_id)
    REFERENCES users (id);

ALTER TABLE message_deleted
  ADD CONSTRAINT FK_messages_TO_message_deleted
    FOREIGN KEY (message_id)
    REFERENCES messages (id);

ALTER TABLE rooms
  ADD CONSTRAINT FK_users_TO_rooms
    FOREIGN KEY (user_id1)
    REFERENCES users (id);

ALTER TABLE rooms
  ADD CONSTRAINT FK_users_TO_rooms1
    FOREIGN KEY (user_id2)
    REFERENCES users (id);

ALTER TABLE rooms
  ADD CONSTRAINT FK_messages_TO_rooms
    FOREIGN KEY (last_message_id)
    REFERENCES messages (id);

ALTER TABLE messages
  ADD CONSTRAINT FK_rooms_TO_messages
    FOREIGN KEY (room_id)
    REFERENCES rooms (id);

ALTER TABLE message_reads
  ADD CONSTRAINT FK_users_TO_message_reads
    FOREIGN KEY (user_id)
    REFERENCES users (id);

ALTER TABLE message_reads
  ADD CONSTRAINT FK_rooms_TO_message_reads
    FOREIGN KEY (room_id)
    REFERENCES rooms (id);

ALTER TABLE likes
  ADD CONSTRAINT FK_users_TO_likes
    FOREIGN KEY (user_id)
    REFERENCES users (id);