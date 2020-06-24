class Solution {
    public int calculate(String s) {
        Stack<Integer> stack = new Stack<>();
        StringBuilder number = new StringBuilder();
        int N=s.length(), i=0;
        for(;i<N;i++){
            char c = s.charAt(i);
            number.setLength(0);
            number.append(c);
            if( Character.isDigit(c) ){
                while( i+1 < N && (Character.isDigit(s.charAt(i+1)) || s.charAt(i+1) == ' ') ){
                    i++;
                    if( s.charAt(i) != ' ')
                        number.append(s.charAt((i)));
                }
                stack.push(Integer.parseInt(number.toString()));
            }
            else if( c == '*' || c == '/'){
                number.setLength(0);
                while( i+1 < N && (Character.isDigit(s.charAt(i+1)) || s.charAt(i+1) == ' ') ){
                    i++;
                    if( s.charAt(i) != ' ')
                        number.append(s.charAt((i)));
                }
                int secOperand = Integer.parseInt(number.toString());
                if( c == '*' )
                    stack.push(stack.pop()*secOperand);
                else
                    stack.push(stack.pop()/secOperand);
            }
            else if( c == '-' || c == '+'){
                number.setLength(0);
                if( c == '-')
                    number.append('-');
                while( i+1 < N && (Character.isDigit(s.charAt(i+1)) || s.charAt(i+1) == ' ') ){
                    i++;
                    if( s.charAt(i) != ' ')
                        number.append(s.charAt((i)));
                }
                stack.push(Integer.parseInt(number.toString()));
            }
        }
        int sum = 0;
        while(!stack.isEmpty()){
            sum += stack.pop();
        }
        return sum;
    }
}
