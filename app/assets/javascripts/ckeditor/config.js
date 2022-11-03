CKEDITOR.editorConfig = function (config) {
  config.toolbar = [
    {
      name: "clipboard",
      items: [
        "Cut",
        "Copy",
        "Paste",
        "PasteText",
        "PasteFormWord",
        "–",
        "Undo",
        "Redo",
      ],
    },
    { name: "editing", items: ["Scayt"] },
    { name: "links", items: ["Link", "Unlink", "Anchor"] },
    {
      name: "insert",
      items: ["Image", "Table", "HorizontaRule", "SpecialChar"],
    },
    { name: "tool", items: ["Maximize"] },
    { name: "document", items: ["Source"] },
  ];
};
