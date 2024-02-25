class CommentImgItemModel {
  final int id;
  final String resource;
  final String description;
  final bool isSVG;

  CommentImgItemModel(
      {required this.id,
      required this.resource,
      required this.isSVG,
      required this.description});
}
