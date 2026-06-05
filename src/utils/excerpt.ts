export const stripMarkdown = (content: string): string =>
  content
    .replace(/```[\s\S]*?```/g, " ")
    .replace(/`[^`]*`/g, " ")
    .replace(/!\[[^\]]*\]\([^)]*\)/g, " ")
    .replace(/\[([^\]]*)\]\([^)]*\)/g, "$1")
    .replace(/<[^>]+>/g, " ")
    .replace(/(^|\s)[#>*_~\-]+/g, " ")
    .replace(/\s+/g, " ")
    .trim();

export const createExcerpt = (content: string, maxLength = 180): string => {
  const plainText = stripMarkdown(content);
  if (plainText.length <= maxLength) return plainText;
  const clipped = plainText.slice(0, maxLength);
  const lastSpace = clipped.lastIndexOf(" ");
  return `${(lastSpace > 0 ? clipped.slice(0, lastSpace) : clipped).trim()}...`;
};
