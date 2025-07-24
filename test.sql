CREATE TABLE users
(
  id              BIGINT   NOT NULL AUTO_INCREMENT COMMENT '인덱스',
  userId          VARCHAR  NOT NULL COMMENT '이메일',
  password        VARCHAR  NOT NULL COMMENT '비밀번호',
  name            VARCHAR  NULL     COMMENT '이름',
  phone           INT      NULL     COMMENT '전화번호',
  profile_photo   VARCHAR  NULL     COMMENT '프로필사진',
  email_cert_code VARCHAR  NULL     COMMENT '이메일인증코드',
  email_cert_date DATETIME NULL     COMMENT '이메일인증일',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '가입일자',
  PRIMARY KEY (Id)
) COMMENT '사용자 테이블';



CREATE TABLE follows (
    follower_id BIGINT NOT NULL,
    followee_id BIGINT NOT NULL,
    followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (follower_id, followee_id),

    FOREIGN KEY (follower_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (followee_id) REFERENCES users(id) ON DELETE CASCADE,

    CHECK (follower_id <> followee_id)
);



CREATE TABLE denied_user (
    denier_id BIGINT NOT NULL,
    denied_id BIGINT NOT NULL,
    denied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (denier_id, denied_id),

    FOREIGN KEY (denier_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (denied_id) REFERENCES users(id) ON DELETE CASCADE,

    CHECK (denier_id <> denied_id)
);
