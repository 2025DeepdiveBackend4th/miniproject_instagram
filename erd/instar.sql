CREATE TABLE users
(
  id              BIGINT    NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  email           VARCHAR   NOT NULL COMMENT '이메일',
  password        VARCHAR   NOT NULL COMMENT '비밀번호',
  name            VARCHAR   NULL     COMMENT '이름',
  phone           INT       NULL     COMMENT '전화번호',
  profile_photo   VARCHAR   NULL     COMMENT '프로필사진',
  email_cert_code VARCHAR   NULL     COMMENT '이메일인증코드',
  email_cert_date DATETIME  NULL     COMMENT '이메일인증일',
  created_at      TIMESTAMP NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '가입일자',
  updated_at      TIMESTAMP NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '수정일자',
  PRIMARY KEY (id)
) COMMENT '사용자 테이블';


CREATE TABLE denied_users
(
  denier_use_id  BIGINT    NOT NULL,
  denied_user_id BIGINT    NOT NULL,
  denied_at      TIMESTAMP NULL     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (denier_use_id, denied_user_id)
);

CREATE TABLE follows
(
  follower_user_id BIGINT    NOT NULL,
  followee_user_id BIGINT    NOT NULL,
  followed_at      TIMESTAMP NULL     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (follower_user_id, followee_user_id)
);


ALTER TABLE follows
  ADD CONSTRAINT FK_users_TO_follows
    FOREIGN KEY (follower_user_id)
    REFERENCES users (id);

ALTER TABLE follows
  ADD CONSTRAINT FK_users_TO_follows1
    FOREIGN KEY (followee_user_id)
    REFERENCES users (id);

ALTER TABLE denied_users
  ADD CONSTRAINT FK_users_TO_denied_users
    FOREIGN KEY (denier_use_id)
    REFERENCES users (id);

ALTER TABLE denied_users
  ADD CONSTRAINT FK_users_TO_denied_users1
    FOREIGN KEY (denied_user_id)
    REFERENCES users (id);

/*******************************************************************************/


CREATE TABLE DM_Rooms (
  room_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user1_id VARCHAR(64) NOT NULL,
  user2_id VARCHAR(64) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_msg_id BIGINT,
  FOREIGN KEY (user1_id) REFERENCES Users(user_id),
  FOREIGN KEY (user2_id) REFERENCES Users(user_id)
);

CREATE TABLE DM_Messages (
  message_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  room_id BIGINT NOT NULL,
  sender_id VARCHAR(64) NOT NULL,
  msg_type VARCHAR(16) NOT NULL,
  content TEXT,
  sent_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY (room_id) REFERENCES Rooms(room_id),
  FOREIGN KEY (sender_id) REFERENCES Users(user_id)
);

CREATE TABLE DM_Reads (
  room_id BIGINT NOT NULL,
  user_id VARCHAR(64) NOT NULL,
  last_read_msg_id BIGINT,
  PRIMARY KEY (room_id, user_id),
  FOREIGN KEY (room_id) REFERENCES Rooms(room_id),
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE DM_Deleted (
  message_id BIGINT NOT NULL,
  user_id VARCHAR(64) NOT NULL,
  deleted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (message_id, user_id),
  FOREIGN KEY (message_id) REFERENCES Messages(message_id),
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

