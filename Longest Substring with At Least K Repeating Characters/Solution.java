class Solution {
    public int longestSubstring(String s, int k) {
        int [] freq = new int[26];
        int start=0, end=s.length()-1;
        for(char c : s.toCharArray()){
            freq[c-'a']++;
        }
        boolean valid=true;
        int i=0;
        for(i=0;i<s.length()&&valid;i++){
            if( freq[s.charAt(i)-'a'] < k){
                valid=false;
                break;
            }
        }
        if( valid )
            return s.length();
        int left = longestSubstring(s.substring(0, i), k);
        int right = longestSubstring(s.substring(i+1, s.length()), k);
        return Math.max(left, right);
    }
}
