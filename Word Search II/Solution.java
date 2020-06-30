class Solution {
    public List<String> findWords(char[][] board, String[] words) {
        Set<String> set = new HashSet<>();
        if( board.length == 0 || board[0].length == 0)
            return new ArrayList<>();
        for(String word : words){
            boolean [][] visited = new boolean[board.length][board[0].length];
            boolean wordFound = false;
            for(int r=0;r<board.length;r++)
                for(int c=0;c<board[0].length;c++){
                    if( dfs(visited, board, word, r, c, 0) ){
                        set.add(word);
                        wordFound=true;
                        break;
                    }
                    if( wordFound )
                        break;
                }
        }
        return new ArrayList(set);
    }
    
    boolean dfs(boolean [] [] visited, char[][] board, String word, int row, int col, int wordIdx){
        if( wordIdx == word.length())
            return true;
        if( row < 0 || row >= board.length ||
          col < 0 || col >= board[0].length || visited[row][col] )
            return false;
        if( board[row][col] == word.charAt(wordIdx) ) {
            visited[row][col] = true;
            wordIdx++;
            boolean found = dfs(visited, board, word, row+1, col, wordIdx) ||
                  dfs(visited, board, word, row-1, col, wordIdx) ||
                  dfs(visited, board, word, row, col+1, wordIdx) ||
                  dfs(visited, board, word, row, col-1, wordIdx);
            if( found )
                return true;
            else
                visited[row][col]=false;
        }
        return false;
    }
}
