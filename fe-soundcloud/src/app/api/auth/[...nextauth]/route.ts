import NextAuth from "next-auth"
import GithubProvider from "next-auth/providers/github"
import GoogleProvider from "next-auth/providers/google"
import { AuthOptions } from "next-auth"
import { sendRequest } from "@/utils/api"
import CredentialsProvider from "next-auth/providers/credentials";


const BACKEND_ACCESS_TOKEN_LIFETIME = 45 * 60;  

const getCurrentEpochTime = () => {
  return Math.floor(new Date().getTime() / 1000);
};

export const authOptions : AuthOptions = {
  secret: process.env.NEXTAUTH_SECRET,
  providers: [
    CredentialsProvider({
      name: "Credentials",
      credentials: {
        username: { label: "Username", type: "text" },
        password: { label: "Password", type: "password" }
      },
     
      async authorize(credentials, req) {
        const bodyObject = new URLSearchParams();
        bodyObject.append('username', credentials?.username || '');
        bodyObject.append('password', credentials?.password || '');
        bodyObject.append('client_id', process.env.DJANGO_CLIENT_ID || '');
        bodyObject.append('client_secret', process.env.DJANGO_CLIENT_SECRET || '');
        bodyObject.append('grant_type', 'password');
        const response = await fetch(`${process.env.NEXT_PUBLIC_BACKEND_URL}/o/token/`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: bodyObject.toString(),
        });
        const res = await response.json();
        if (!res.error) {
          return res as any
        } else {
          throw new Error(res.error)
        }
      }
    }),
    GithubProvider({
      clientId: process.env.GITHUB_ID!, 
      clientSecret: process.env.GITHUB_SECRET!,
    }),
    GoogleProvider({
      clientId: process.env.GOOGLE_ID!, 
      clientSecret: process.env.GOOGLE_SECRET!,
    }),
  ],
  callbacks:{
    async jwt({token,user,account,profile,trigger}){
      if(trigger ==="signIn" && account?.provider === "github"){
        const res = await sendRequest<backendResponse>({
          url: `${process.env.NEXT_PUBLIC_BACKEND_URL}/github/`,
          method: "POST",
          body: { access_token: account?.access_token }
        })
       if(res){
        token.user = res.user;
        token.access_token = res.access;
        token.refresh_token = res.refresh;
       }
      }else if(trigger ==="signIn" && account?.provider === "credentials"){
        //@ts-ignore
        token.user = user.user;
          //@ts-ignore
        token.access_token = user.access_token;
          //@ts-ignore
        token.refresh_token = user.refresh_token;
      }
      else if(trigger ==="signIn" && account?.provider === "google"){
        //@ts-ignore
        const res = await sendRequest<backendResponse>({
          url: `${process.env.NEXT_PUBLIC_BACKEND_URL}/google/`,
          method: "POST",
          body: { access_token: account?.access_token }
        })
        console.log(res)
       if(res){
        token.user = res.user;
        token.access_token = res.access;
        token.refresh_token = res.refresh;
       }
      }
      return token;
    },
    session({session,token,user}){
      if(token){
        session.access_token = token.access_token;
        session.refresh_token = token.refresh_token
        session.user = token.user
      }
      return session;
    }
  },
  pages:{
    signIn:"/auth/signin"
  }
}

const handler = NextAuth(authOptions)

export { handler as GET, handler as POST }