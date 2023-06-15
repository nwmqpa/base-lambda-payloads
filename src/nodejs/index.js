const handler = async (event) => {
  return {
    message: JSON.stringify({
      message: "Hello World!",
    })
  };
};

export { handler };
