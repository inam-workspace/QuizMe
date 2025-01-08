//Dart
export 'dart:async';
export 'dart:io';
export 'dart:convert';
//App Config
export 'package:quiz_me/config/hive_config.dart';
export 'package:quiz_me/config/app_config.dart';
//Packages
export 'package:hive_flutter/hive_flutter.dart';
export 'package:provider/provider.dart';
export 'package:flutter_svg/svg.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:toastification/toastification.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:dartz/dartz.dart' hide State, Order;
export 'package:file_picker/file_picker.dart';
export 'package:syncfusion_flutter_pdf/pdf.dart';
export 'package:appinio_swiper/appinio_swiper.dart';
export 'package:dio/dio.dart';
export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:flip_card/flip_card.dart';
export 'package:docx_to_text/docx_to_text.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
export 'package:flutter_markdown/flutter_markdown.dart';

//Flutter
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/gestures.dart';
//Main
export 'package:quiz_me/main/landing/screen/app.dart';
export 'package:quiz_me/main/landing/provider/app_provider.dart';
export 'package:quiz_me/main/routes/app_routes.dart';
//Navigation
export 'package:quiz_me/main/navigation/navigation_service.dart';
export 'package:quiz_me/main/navigation/navigation_animation.dart';
//App Core
export 'package:quiz_me/core/theme/app_theme.dart';
export 'package:quiz_me/core/theme/app_colors.dart';
export 'package:quiz_me/core/theme/text_style.dart';
export 'package:quiz_me/core/theme/text_theme.dart';
export 'package:quiz_me/core/connection/network_info.dart';
export 'package:quiz_me/core/global/global_methods.dart';
export 'package:quiz_me/core/global/functions/gap.dart';
export 'package:quiz_me/core/global/functions/log_message.dart';
export 'package:quiz_me/core/global/functions/resize.dart';
export 'package:quiz_me/core/global/functions/enums.dart';
export 'package:quiz_me/core/global/functions/const.dart';
export 'package:quiz_me/core/global/widgets/custom_button.dart';
export 'package:quiz_me/core/global/widgets/item_tile.dart';
export 'package:quiz_me/core/global/widgets/add_item.dart';
export 'package:quiz_me/core/global/widgets/blurd_bottom_sheet.dart';
export 'package:quiz_me/core/global/widgets/content_sheet.dart';
export 'package:quiz_me/core/errors/failure.dart';
export 'package:quiz_me/core/errors/exceptions.dart';
//Features
export 'package:quiz_me/features/dashboard/screen/dashboard_screen.dart';
export 'package:quiz_me/features/dashboard/provider/dashboard_provider.dart';
export 'package:quiz_me/features/add_guide/view/screen/add_guide_screen.dart';
export 'package:quiz_me/features/add_guide/view/provider/add_guide_provider.dart';
export 'package:quiz_me/features/add_guide/view/widget/add_chapter_card.dart';
export 'package:quiz_me/features/add_guide/view/widget/add_chapters_page.dart';
export 'package:quiz_me/features/add_guide/view/widget/name_guide_page.dart';
export 'package:quiz_me/features/add_guide/view/widget/set_icon_page.dart';
export 'package:quiz_me/features/home/widget/content_title.dart';
export 'package:quiz_me/features/home/widget/quick_access_card.dart';
export 'package:quiz_me/features/home/widget/logged_in_details.dart';
export 'package:quiz_me/features/home/screen/home_screen.dart';
export 'package:quiz_me/features/home/widget/study_guides_sheet.dart';

export 'package:quiz_me/features/mock_test/view/screen/mock_test_screen.dart';
export 'package:quiz_me/features/quiz/view/screen/quiz_screen.dart';
export 'package:quiz_me/features/study_guide/screen/study_guide_screen.dart';

export 'package:quiz_me/features/notes/data/model/notes_model.dart';
export 'package:quiz_me/features/notes/data/source/notes_remote.dart';
export 'package:quiz_me/features/notes/logic/entities/notes_entity.dart';
export 'package:quiz_me/features/notes/logic/repository/notes_repository.dart';
export 'package:quiz_me/features/notes/data/source/notes_local.dart';

//Utils
export 'package:quiz_me/features/add_guide/logic/repository/guide_details_repo.dart';
export 'package:quiz_me/features/add_guide/logic/entities/guide_details_entity.dart';
export 'package:quiz_me/features/add_guide/logic/entities/chapter_details_entity.dart';
export 'package:quiz_me/features/add_guide/logic/entities/icon_details_entity.dart';
export 'package:quiz_me/features/add_guide/logic/usecase/get_guide_details.dart';
export 'package:quiz_me/features/add_guide/data/repository/guide_details_repo_impl.dart';
export 'package:quiz_me/features/add_guide/data/source/guide_details_local_source.dart';
export 'package:quiz_me/features/add_guide/data/model/guide_details_model.dart';
export 'package:quiz_me/features/add_guide/data/source/guide_details_remote_source.dart';

export 'package:quiz_me/features/flashcards/view/provider/flashcards_provider.dart';
export 'package:quiz_me/features/flashcards/view/screen/flashcards_screen.dart';
export 'package:quiz_me/features/flashcards/view/widget/flashcard_swapper.dart';
export 'package:quiz_me/features/flashcards/data/models/flashcard_model.dart';
export 'package:quiz_me/features/flashcards/data/source/flashcard_source.dart';
export 'package:quiz_me/features/flashcards/data/repository/flashcard_repo_impl.dart';
export 'package:quiz_me/features/flashcards/logic/entities/flashcard_entity.dart';
export 'package:quiz_me/features/flashcards/logic/repository/flashcard_repo.dart';
export 'package:quiz_me/features/flashcards/logic/usecase/get_flashcard.dart';
export 'package:quiz_me/features/flashcards/view/provider/flashcard_preview_provider.dart';

export 'package:quiz_me/features/quiz/data/models/quiz_model.dart';
export 'package:quiz_me/features/quiz/logic/entities/quiz_entity.dart';
export 'package:quiz_me/features/quiz/logic/repository/quiz_repo.dart';
export 'package:quiz_me/features/quiz/data/source/quiz_source.dart';
export 'package:quiz_me/features/quiz/data/repository/quiz_repo_impl.dart';
export 'package:quiz_me/features/quiz/logic/usecase/get_quiz.dart';
export 'package:quiz_me/features/quiz/view/screen/quiz_preview.dart';
export 'package:quiz_me/features/quiz/view/provider/attempt_quiz_provider.dart';
export 'package:quiz_me/features/quiz/view/widget/quiz_question_card.dart';
export 'package:quiz_me/features/quiz/view/screen/attempt_quiz_screen.dart';
export 'package:quiz_me/features/quiz/view/screen/quiz_score_sheet.dart';

export 'package:quiz_me/features/mock_test/data/models/mock_test_model.dart';
export 'package:quiz_me/features/mock_test/logic/entities/mock_test_entity.dart';
export 'package:quiz_me/features/mock_test/logic/repository/mock_test_repo.dart';
export 'package:quiz_me/features/mock_test/data/source/mock_test_source.dart';
export 'package:quiz_me/features/mock_test/data/repository/mock_test_repo_impl.dart';
export 'package:quiz_me/features/mock_test/logic/usecase/get_mock_test.dart';
export 'package:quiz_me/features/mock_test/view/screen/mock_test_score_sheet.dart';
export 'package:quiz_me/features/mock_test/view/screen/mock_test_preview.dart';
export 'package:quiz_me/features/mock_test/view/provider/mock_test_preview_provider.dart';
export 'package:quiz_me/features/mock_test/view/screen/attempt_mock_test_screen.dart';
export 'package:quiz_me/features/mock_test/view/provider/attempt_mock_test_provider.dart';
export 'package:quiz_me/features/mock_test/view/widget/mock_test_question_card.dart';

export 'package:quiz_me/core/global/dialogs/custom_dialogs.dart';
export 'package:quiz_me/features/flashcards/view/screen/flashcards_preview.dart';
export 'package:quiz_me/features/quiz/view/provider/quiz_preview_provider.dart';

export 'package:quiz_me/utils/auth/data/model/auth_model.dart';
export 'package:quiz_me/utils/auth/logic/repository/auth_repository.dart';
export 'package:quiz_me/utils/auth/data/repository/auth_repository_impl.dart';
export 'package:quiz_me/utils/auth/logic/usecase/get_auth.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:google_sign_in/google_sign_in.dart';

export 'package:quiz_me/utils/auth/view/screens/forget_password_screen.dart';
export 'package:quiz_me/utils/auth/view/screens/login_screen.dart';
export 'package:quiz_me/utils/auth/view/screens/registration_screen.dart';
export 'package:quiz_me/utils/auth/view/provider/login_provider.dart';
export 'package:quiz_me/utils/auth/view/widget/auth_footer.dart';
export 'package:quiz_me/utils/auth/view/widget/auth_header.dart';
export 'package:quiz_me/utils/auth/data/model/streak_model.dart';

export 'package:quiz_me/features/chat/view/screen/chat_screen.dart';
export 'package:quiz_me/features/flashcards/view/screen/flashcards_score_sheet.dart';
export 'package:quiz_me/features/notes/view/screen/notes_screen.dart';
export 'package:quiz_me/features/chat/data/source/chat_source_remote.dart';
export 'package:quiz_me/features/chat/logic/entities/chat_entity.dart';
export 'package:quiz_me/features/chat/logic/repository/chat_repository.dart';
export 'package:quiz_me/features/chat/data/repository/chat_repository_impl.dart';
export 'package:quiz_me/features/chat/logic/usecase/get_chat.dart';
export 'package:quiz_me/features/chat/view/provider/chat_provider.dart';
export 'package:quiz_me/features/chat/view/widget/chat_bubble.dart';
export 'package:quiz_me/features/notes/view/provider/notes_preview_provider.dart';
export 'package:quiz_me/features/notes/view/provider/notes_provider.dart';
export 'package:quiz_me/features/onboarding/screen/splash_screen.dart';
export 'package:quiz_me/features/drawer/screen/drawer_screen.dart';
