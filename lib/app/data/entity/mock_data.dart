import 'package:final_app/app/data/entity/user.dart';
import 'package:final_app/app/data/entity/video.dart';

User currentUser = User('main_user', 'https://picsum.photos/seed/1/200');
User user1 = User('Hoàng Long 🦋', 'https://picsum.photos/seed/2/200');
User user2 = User('Hoàng Anh 🦋', 'https://picsum.photos/seed/3/200');
User user3 = User('Thành Đạt 🦋', 'https://picsum.photos/seed/4/200');

final List<Video> videos = [
  Video('v1.mp4', currentUser, 'Kênh 14 là một trang web thông tin điện tử tổng hợp hoạt động tại Việt Nam. Nội dung của Kênh 14 đa phần viết về chủ đề giải trí, xã hội, người của công chúng... ',
      'audioName', 1238945, 45456),
  Video('v2.mp4', user1, 'hướng đến đối tượng chính là các độc giả trẻ như tuổi thanh thiếu niên, học sinh, sinh viên.',
      'audioName', 21454, 21356),
  Video('v3.mp4', user2, 'KENH14: Tin tức GIẢI TRÍ - XÃ HỘI Việt Nam và Thế Giới 24h qua. Tin HAY, HOT nhất của SAO VIỆT, Kpop từ kênh 14.VN được cập nhật liên tục.',
      'audioName', 75849, 7462),
  Video('v4.mp4', user3, 'Những chuyên mục chính của Kênh 14 bao gồm: Star; Musik; Ciné; TV Show; Beauty & Fashion; Đời sống; Xã hội; Thế giới; Sức khỏe; Ăn - quẩy ...',
      'audioName', 190283476, 451244),
];